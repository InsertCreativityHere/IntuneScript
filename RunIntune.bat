@echo off

xcopy "%~dp0\AustinsIntuneScript.ps1" "C:\"
if NOT %ERRORLEVEL% EQU 0 GOTO :failure
powershell -Command "Start-Process powershell -Verb runAs -ArgumentList '-noexit','-ExecutionPolicy','bypass','-File','C:\AustinsIntuneScript.ps1'"
exit

:failure
echo.
echo The script failed to start.
echo Did you remember to Right-Click and "Run As Administrator"?...
PAUSE