@echo off
setlocal
set ROOT=%~dp0
set SOURCE=%1
set NAME=%2

if "%SOURCE%" == "" goto :usage
if "%NAME%" == "" goto :usage

if NOT EXIST %SOURCE% (
  echo Source file %SOURCE% not found1
  goto :usage
)

goto :compile

rem ============================================================================
:usage
echo Usage: %0 [source.yaml] [name]
echo.
echo Compiles the given ESPHome source file [source.yaml] to an ESP firmware [name].bin.
echo Privide the name as defined in the yaml source file.
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
  -v "esphome-config:/config" ^
  -v "esphome-platformio:/root/.platformio" ^
  -v "%ROOT%:/mnt/host" ^
  ghcr.io/esphome/esphome ^
  -c "cp /mnt/host/*.yaml . && esphome compile %SOURCE% && cp /config/.esphome/build/%NAME%/.pioenvs/%NAME%/firmware.factory.bin /mnt/host/bin/%NAME%.bin"

echo Firmware saved as: %ROOT%bin\%NAME%.bin
dir %ROOT%bin\%NAME%.bin
goto :end

rem ============================================================================

:end
endlocal
goto :eof
