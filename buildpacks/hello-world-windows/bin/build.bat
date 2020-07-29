@echo off

echo --- Hello World buildpack

:: INPUT ARGUMENTS
set env_dir=%2\env
set layers_dir=%1
set plan_path=%3

:: ENV VARS
echo env_dir: %env_dir%

:: LAYERS
echo layers_dir: %layers_dir}%

:: PLAN
echo plan_path: %plan_path%
echo plan contents:
type %plan_path%

echo --- Done
