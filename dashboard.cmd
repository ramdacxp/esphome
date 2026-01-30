@echo off
echo Starting ESPHome Dashboard ...
call %~dp0esphome.cmd dashboard --address localhost /config %*

