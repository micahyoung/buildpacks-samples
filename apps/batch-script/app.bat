@echo off

for %%I in (
"    |'-_ _-'|       ____          _  _      _                      _             _         "
"    |   |   |      |  _ \        (_)| |    | |                    | |           (_)        "
"     '-_|_-'       | |_) | _   _  _ | |  __| | _ __    __ _   ___ | | __ ___     _   ___   "
"|'-_ _-'|'-_ _-'|  |  _ < | | | || || | / _\` ||'_ \  / _\ | / __|| |/ // __|   | | / _ \\ "
"|   |   |   |   |  | |_) || |_| || || || (_| || |_) || (_| || (__ |   < \__ \ _ | || (_) | "
" '-_|_-' '-_|_-'   |____/  \__,_||_||_| \__,_|| .__/  \__,_| \___||_|\_\|___/(_)|_| \___/  "
"                                              | |                                          "
"                                              |_|                                          "
) do echo %%~I

echo Here are the contents of the current working directory:
dir /q /s

echo Set output
set
echo End set output

echo The value of FOO is %FOO%