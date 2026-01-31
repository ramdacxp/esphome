@rem Podman Desktop 4 Windows WSL2
@echo off
setlocal

rem Info about ESPHome env vars:
rem https://github.com/esphome/feature-requests/issues/2759

set ROOT=%~dp0
set CFG=%ROOT%config\

rem start podman machine
podman machine start 2>NUL

rem Create container volume, if not exists
podman volume inspect esphome-data >NUL 2>&1
if errorlevel 1 (
  echo Creating volume esphome-data...
  podman volume create esphome-data
)

rem Create secrets file, if not exists
if not exist %CFG%secrets.yaml (
  echo Creating a sample secrets.yaml from template ...
  copy %CFG%secrets.yaml.template %CFG%secrets.yaml
)

rem run ESPHome with given command line options

rem Do not set container name to be able to run multiple commands in parallel
rem e.g. dashboard and compile
rem --name esphome ^
podman run ^
  --rm ^
  -it ^
  --net=host ^
  -v esphome-data:/cache ^
  -v esphome-data:/build ^
  -v "%CFG%:/config" ^
  ghcr.io/esphome/esphome %*

endlocal
