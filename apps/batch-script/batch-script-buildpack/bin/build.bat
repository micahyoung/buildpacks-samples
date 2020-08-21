@echo off
echo --- Batch script buildpack

:: 1. INPUT ARGUMENTS
set layers_dir=%1

:: 2. SET DEFAULT START COMMAND
echo [[processes]]>> %layers_dir%\launch.toml
echo type = "web" >> %layers_dir%\launch.toml
echo command = "app.bat" >> %layers_dir%\launch.toml

:: 3. ADD PROFILE SCRIPT THAT SETS ENV VAR
if not exist %layers_dir%\batch-script-buildpack.toml (
    echo launch = true>> %layers_dir%\batch-script-buildpack.toml
)

mkdir %layers_dir%\batch-script-buildpack\profile.d\web\
echo set FOO=bar>> %layers_dir%\batch-script-buildpack\profile.d\web\setter.bat

:: LIST CONTENTS
echo --- Hello Batch Script buildpack
echo Here are the contents of the current working directory:
dir /q /s

set
