@echo off

echo Creating Config Volume ...
docker volume create esphome-config

echo Creating Cache Volume ...
docker volume create esphome-cache

echo Creating PlatformIO Volume ...
docker volume create esphome-platformio

rem --network host ^

docker run -it --rm ^
  --name "esphome-dashboard" ^
  --entrypoint "/bin/bash" ^
  -v "esphome-config:/config" ^
  -v "esphome-cache:/cache" ^
  -v "esphome-platformio:/root/.platformio" ^
  -v "%~dp0:/mnt/host" ^
  -p 6052:6052 ^
  -e ESPHOME_DASHBOARD_USE_PING=true ^
  ghcr.io/esphome/esphome ^
  -c "cp /mnt/host/*.yaml . && esphome dashboard /config"
