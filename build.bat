@echo off
msbuild client.sln /p:Configuration=Release /p:Platform=x86 /t:Clean,Build

