# Docker hosted ESPHome

* This repo provides an `esphome.cmd`, which starts the ESPHome Dashboard on the local PC.  
  Dashboard address: <http://localhost:6052/>
* If the repo's root folder is opened in [VSCode](https://code.visualstudio.com/), the [ESPHome extension](https://marketplace.visualstudio.com/items?itemName=ESPHome.esphome-vscode) provides syntax highlighting for the `.yaml` files.

**Important:**
I was not able to successfully compile on a **Windows on ARM** laptop ("Copilot PC").
So headers are missing in the AMR variant of related tools.
The same code compiles just fine on AMD64.

## Usage

* Start new project: `esphome wizard test.yaml`
* Build & upload project: `esphome run template-d1_mini.yaml`
* Run [Dashboard](http://localhost:6052/): `esphome dashboard /config`

## Links

* Install [ESPHome via Docker](https://esphome.io/guides/getting_started_command_line#installation)
* [VSCode Extension](https://github.com/esphome/esphome-vscode)
* [ESPHome Web Installer](https://web.esphome.io/) to flash a given `.bin` via browser connected via `COMx`
