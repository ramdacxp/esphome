# Podman hosted ESPHome development

This repo provides scripts to develop ESPHome based projects on Windows.  
It uses a containerized version of the ESPHome tools running in PodMan.

**Hint:**
The old Docker based version of this repo can be found in the
[v1 branch](https://github.com/ramdacxp/esphome/tree/v1).

## Installation

* `git` Version Control
* [Visual Studio Code](https://code.visualstudio.com/) with [ESPHome extension](https://marketplace.visualstudio.com/items?itemName=ESPHome.esphome-vscode) provides syntax highlighting for the `.yaml` files.
* WSL2 (run `wsl --install` followed by `wsl --update`)
* [Podman Desktop](https://podman-desktop.io/) for Windows (including PodMan)

## Usage

* Start podman backend with: `podman machine start`
* Use `esphome.cmd` to execute all esphome shell commands, e.g. `esphome --help`
* Use `dashboard.cmd` to start ESPHome website at <http://localhost:6052>

If the repo folder is opened in VSCode, intellisense for ESPHome `.yaml` is support.
You can use the default build task (`F6`) to compile the active `.yaml` file.
The statusbar contains buttons to execute common tasks.

## Links

* Install [ESPHome via Docker](https://esphome.io/guides/getting_started_command_line#installation)
* [VSCode Extension](https://github.com/esphome/esphome-vscode)
* [ESPHome Web Installer](https://web.esphome.io/) to flash a given `.bin` via browser connected via `COMx`.
  * If the board has a `BOOT` key, press and hold it while confirming the installation wit `[INSTALL]`.
  * It helps to power off the board before connecting the serial port.
    Optionally holds down the `BOOT` key while connecting the board to the power source.
  * Try to connect `GPIO0` and `GND` if the board has no `BOOT` key, [details here](https://esphome.io/guides/physical_device_connection/#connecting-to-the-esp).
* [CP210x Universal Windows Driver](https://www.silabs.com/software-and-tools/usb-to-uart-bridge-vcp-drivers?tab=downloads) required on Windows@Arm64 to flash Esp32 NodeMPU boards.

## Projects

ESPHome projects are available in the folder `/config`.

### Hub75 Matrix Display

`hub75-64x64.yaml` drives a [64x64 Hub75 1/32-scan panel](https://de.aliexpress.com/item/1005005720691780.html?spm=a2g0o.order_list.order_list_main.5.21ef5c5fzbAAB2&gatewayAdapt=glo2deu) with an ESP32 NodeMCU.

![The Matrix matrix](doc/matrix.gif)

| Input Plug | Related Cable |
|------------|---------------|
| ![Pinout Cable](doc/hub75-input.png) | ![Pinout Cable](doc/hub75-cable.png) |
| | The marked pins are connected |

| Cable | ESP32 |
|-------|-------|
| ![Pinout Cable](doc/hub75-pins-cable.png) | ![Pinout Cable](doc/hub75-pins-esp32.png) |

* Based on [this example](https://github.com/TillFleisch/ESPHome-HUB75-MatrixDisplayWrapper/blob/main/example.yaml)

* GitHub
  * ESPHome wrapper
    [TillFleisch/ESPHome-HUB75-MatrixDisplayWrapper](https://github.com/TillFleisch/ESPHome-HUB75-MatrixDisplayWrapper)

  * HUB75 matrix panel lib for ESP32
    [mrcodetastic/ESP32-HUB75-MatrixPanel-DMA](https://github.com/mrcodetastic/ESP32-HUB75-MatrixPanel-DMA)

  * Another ESPHome wrapper
    [sekureco42/esphome-hub75](https://github.com/sekureco42/esphome-hub75)

### Framed Utopia

`utopia.yaml` displays random "Utopia" messages on a HUB75 64x64 matrix.
Short, nice, utopic statements - simply to make you smile.

This is basically the ESPHome version of [this project](https://github.com/Esshahn/esp32-dotmatrix-utopia-offline) shared by [Ingo Hinterding](https://github.com/Esshahn).

![Framed Utopia](doc/utopia.jpg)

* [Utopia messages (German)](https://github.com/Esshahn/esp32-dotmatrix-utopia-offline/blob/29ec1e009be6e6e01db2c21299e1946cc10cb018/esp32-dotmatrix-utopia-offline.ino#L41)

### Casalux LED Bar

`led.yaml` drives a "Casalux LED Bar" on a ESP32 C3 Super Mini.

More details in the Github project [ramdacxp/lichtleiste](https://github.com/ramdacxp/lichtleiste).
