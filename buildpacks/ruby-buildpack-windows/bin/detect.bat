@echo off

if not exist c:\workspace\Gemfile (
    exit 100
)

set plan=%2
set version=2.5.8-1

if exist .ruby-version (
    for /f %%a in ('type .ruby-version') do (
       set version=%%a
    )
)

(
echo provides = [{ name = "ruby" }]
echo requires = [{ name = "ruby", version = "%version%" }]
) > %plan%
