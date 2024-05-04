@Echo off
PowerShell -ExecutionPolicy bypass -File %~dp0\KHEngine_Install.ps1
del .\tmp.log
cmd /k