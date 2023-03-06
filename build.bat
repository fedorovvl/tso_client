@echo off
msbuild client.sln /p:Configuration=Release /p:Platform=x86 /t:Clean,Build
rmdir \S "client\files\content\Adobe AIR"
xcopy client\files\runtime_x64\ client\files\content\ /Y /S
msbuild client.sln /p:Configuration=Release /p:Platform=x86 /t:Clean,Build /p:AssemblyName=client_x64
rmdir \S "client\files\content\Adobe AIR"
xcopy client\files\runtime_x86\ client\files\content\ /Y /S
