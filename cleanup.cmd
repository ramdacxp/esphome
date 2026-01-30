@echo off
echo Cleaning up temp files and podman volume ...
rmdir /S /Q %~dp0config\.esphome
podman volume rm esphome-data
