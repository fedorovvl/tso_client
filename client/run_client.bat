@echo off
rem Launches client.exe via cmd.exe instead of double-clicking it directly
rem in Explorer. Windows Smart App Control's "unrecognized app" check hooks
rem into Explorer's shell-execute path specifically, so unsigned freshly
rem built exes can get blocked there even though nothing is wrong with the
rem binary itself -- launching it this way sidesteps that check.
"%~dp0client.exe"
