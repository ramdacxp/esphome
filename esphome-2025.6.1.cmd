@echo off
setlocal

REM Use script dir as ESPHome config dir
set CONFIGDIR=%~dp0
echo Local ESPHome config directory: %CONFIGDIR%
mkdir %CONFIGDIR% 2>nul

rem --network host ^

docker run -it --rm ^
  -v "%CONFIGDIR%:/config" ^
  -p 6052:6052 ^
  -e ESPHOME_DASHBOARD_USE_PING=true ^
  ghcr.io/esphome/esphome:2025.6.1 ^
  %*

endlocal