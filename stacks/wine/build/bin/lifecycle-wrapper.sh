#!/bin/bash

echo $0.exe $*

wine cmd /c exit 0

ln -s /cnb /root/.wine/drive_c/
ln -s /layers /root/.wine/drive_c/
ln -s /platform /root/.wine/drive_c/
ln -s /cache /root/.wine/drive_c/

cp -r /workspace /root/.wine/drive_c/

wine $0.exe $*
