@Echo off
PowerShell -ExecutionPolicy bypass -File %~dp0\NarkEngine_Install.ps1
del .\tmp.log
cmd /k