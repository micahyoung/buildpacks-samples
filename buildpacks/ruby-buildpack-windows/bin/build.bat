@echo off

echo --- Ruby Buildpack

:: 1. GET ARGS
set layersdir=%1
set plan=%3

:: 2. DOWNLOAD RUBY
set ruby_version=""
for /f "tokens=3" %%a in ('findstr "version" %plan%') do (
    set ruby_version=%%~a
)

echo --- Downloading and extracting Ruby
set rubylayer=%layersdir%\ruby-%ruby_version%
set sevenzip_url=https://www.7-zip.org/a/7za920.zip
set ruby_url=https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-%ruby_version%/rubyinstaller-%ruby_version%-x64.7z
if not exist %rubylayer% (
    curl.exe -L -o 7zip.zip %sevenzip_url%
    if not errorlevel 0 (
        echo failed to download 7zip
        exit %ERRORLEVEL%
    )

    curl.exe -L -o rubyinstaller.7z %ruby_url%
    if not errorlevel 0 (
        echo failed to download ruby
        exit %ERRORLEVEL%
    )

    tar -xf 7zip.zip 7za.exe
    if not errorlevel 0 (
        echo failed to extract 7zip
        exit %ERRORLEVEL%
    )

    7za.exe x rubyinstaller.7z
    if not errorlevel 0 (
        echo failed to extract ruby
        exit %ERRORLEVEL%
    )

    move rubyinstaller-* %rubylayer%
)

:: 3. MAKE RUBY AVAILABLE DURING LAUNCH
(
echo cache = true
echo launch = true
) > %rubylayer%.toml

:: 4. MAKE RUBY AVAILABLE TO THIS SCRIPT
set "PATH=%PATH%;%rubylayer%\bin"
set SystemDrive=C:

:: 5. INSTALL BUNDLER
echo --- Installing bundler
call gem install bundler --no-ri --no-rdoc
if not errorlevel 0 (
    echo failed to gem install
    exit %ERRORLEVEL%
)

:: 6. INSTALL GEMS
set bundlerlayer=%layersdir%\bundler
if not exist %bundlerlayer% (
    mkdir %bundlerlayer%
)

set "_install_gems="
if exist Gemfile.lock (
    for /f %%a in ('certutil -hashfile Gemfile.lock sha256 ^| findstr /v /r "[g-z]"') do (
        set local_bundler_checksum=%%a
    )
) else (
    set _install_gems=1
)

if exist Gemfile.lock (
    for /f "tokens=3" %%a in ('findstr "metadata" %bundlerlayer%.toml') do (
        set remote_bundler_checksum=%%~a
    )
) else (
    set _install_gems=1
)

if not "%local_bundler_checksum%"=="%remote_bundler_checksum%" (
    set _install_gems=1
)

echo install gems %_install_gems%
if "%_install_gems%"=="1" (
    echo --- Installing gems
(
echo cache = true
echo launch = true
echo metadata = "%local_bundler_checksum%"
) > %bundlerlayer%.toml

    call bundle install --path %bundlerlayer% --binstubs %bundlerlayer%\bin
    if not errorlevel 0 (
        echo failed to bundle install
        exit %ERRORLEVEL%
    )
) else (
    echo --- Reusing gems
    call bundle config --local path "%bundlerlayer%"
    call bundle config --local bin "%bundlerlayer%\bin"
)

:: 7. SET DEFAULT START COMMAND
(
echo [[processes]]
echo type = "web"
echo command = "bundle exec ruby app.rb"
echo.
echo [[processes]]
echo type = "worker"
echo command = "bundle exec ruby worker.rb"
) > %layersdir%\launch.toml
