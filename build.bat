@echo off
tar -c -a -f client\files\content.zip -C client\files\content *
msbuild client.sln /p:Configuration=Release /p:Platform=x86 /t:Clean,Build
del /F client\files\content.zip

