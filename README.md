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

## Projects

ESPHome projects are available in the folder `/config`.
If a documentation is available, it can be found in a `.md` file with the same base name as the ESPHome `.yaml`.

## Links

* Install [ESPHome via Docker](https://esphome.io/guides/getting_started_command_line#installation)
* [VSCode Extension](https://github.com/esphome/esphome-vscode)
* [ESPHome Web Installer](https://web.esphome.io/) to flash a given `.bin` via browser connected via `COMx`
