@echo off
setlocal
set ROOT=%~dp0
set SOURCE=%1
set NAME=%2
set COMMAND=compile

if "%SOURCE%" == "" goto :usage
if "%NAME%" == "" goto :usage
if "%3" == "/upload" set COMMAND=upload

if NOT EXIST %SOURCE% (
  echo Source file %SOURCE% not found1
  goto :usage
)

goto :compile

rem ============================================================================
:usage
echo Usage: %0 (source.yaml) (component-name) [/upload]
echo.
echo Compiles the given ESPHome source file source.yaml to an ESP firmware component-name.bin.
echo Component's name must match esphome.name as defined in source.yaml.
echo If /upload is given, the firmware is uploaded to the ESP device via WLAN.
echo.
goto :end

rem ============================================================================

:compile

echo Creating output folder %ROOT%bin ...
mkdir %ROOT%bin 2>NUL

echo Creating Config Volume ...
docker volume create esphome-config

echo Creating PlatformIO Volume ...
docker volume create esphome-platformio

echo Starting EspHome ...
docker run -it --rm^
  --name "esphome-compile" ^
  --entrypoint "/bin/bash" ^
  --network host ^
  -v "esphome-config:/config" ^
  -v "esphome-platformio:/root/.platformio" ^
  -v "%ROOT%:/mnt/host" ^
  ghcr.io/esphome/esphome ^
  -c "cp /mnt/host/*.yaml . && esphome %COMMAND% %SOURCE% && cp /config/.esphome/build/%NAME%/.pioenvs/%NAME%/firmware.factory.bin /mnt/host/bin/%NAME%.bin"

echo Firmware saved as: %ROOT%bin\%NAME%.bin
dir %ROOT%bin\%NAME%.bin
goto :end

rem ============================================================================

:end
endlocal
goto :eof
