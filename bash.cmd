@echo off

echo Creating Config Volume ...
docker volume create esphome-config

echo Creating PlatformIO Volume ...
docker volume create esphome-platformio

echo Starting EspHome ...
docker run -it --rm ^
  --name "esphome-bash" ^
  --entrypoint "/bin/bash" ^
  --network host ^
  -v "esphome-config:/config" ^
  -v "esphome-platformio:/root/.platformio" ^
  -v "%~dp0:/mnt/host" ^
  ghcr.io/esphome/esphome %*
