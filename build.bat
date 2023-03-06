msbuild client.sln /p:Configuration=Release /p:Platform=x86 /t:Clean,Build
rmdir \S "%cd%\client\files\content\Adobe AIR"
xcopy %cd%\client\files\runtime_x64\ %cd%\client\files\content\ /Y /S
msbuild client.sln /p:Configuration=Release /p:Platform=x86 /t:Clean,Build /p:AssemblyName=client_x64
rmdir \S "%cd%\client\files\content\Adobe AIR"
xcopy %cd%\client\files\runtime_x86\ %cd%\client\files\content\ /Y /S
