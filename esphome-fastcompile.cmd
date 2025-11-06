@echo off
setlocal
set ROOT=%~dp0

echo Creating Config Volume ...
docker volume create esphome-config

rem -p 6052:6052 ^
rem --net=host ^

echo Starting EspHome Bash ...
echo.
echo cp /mnt/host/*.yaml .
echo esphome compile xxx.yaml
echo cp /config/.esphome/build/hub75-64x64/.pioenvs/hub75-64x64/firmware.factory.bin /mnt/host/firmware.bin
echo exit
echo.
docker run -it --rm ^
  --name "esphome-bash" ^
  --entrypoint bash ^
  -v "esphome-config:/config" ^
  -v "%ROOT%:/mnt/host" ^
  ghcr.io/esphome/esphome


echo Done.
endlocal
