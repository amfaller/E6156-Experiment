# E6156-Experiment
This repository contains the source code for a small-scale experiment. This supports the midterm paper in E6156: Topics in Software Engineering (Spring 2025).

Author: Tony Faller (af3370@columbia.edu)

## :warning: WARNING :warning:
The code in this repository closely emulates kernel-level malware. Proceed at your own risk.

## General
The idea behind this experiment is to demonstrate the dangers of third-party kernel access. At a surface level, running the included `install.sh` script will create a desktop icon which appears to be a benign video game; indeed, when this icon is double clicked, a dialog box is launched to emulate a game launch.

However, hidden from the user is the installation of the kernel module located in the [`driver`](./driver) directory. This module reads a file (hardcoded to `/home/tony/Documents/mySecret.txt`) and simply prints to kernel output. One can imagine this extending to reading all files in a given system and publishing data via the network, which is a major invasion of privacy completely hidden from the user.

Mimicking modern anti-cheat systems, this kernel module also scans a specific directory for known cheat files. If any such files are found, the game is not launched. Supposedly, this functionality is required at the kernel level because user-level cheat programs can evade user-level anticheat programs. However, it is demonstrated via the script in the [`cheat`](./cheat) directory that user-level cheat programs can in fact evade kernel-level anticheat.

## Getting Started
This experiment was developed on a virtual machine (VM) running Ubuntu 24.10. The only required dependencies are `git` (to clone the repo), `make` and `gcc-14` (both to build the kernel module), and `zenity` (to mimic an arbitrary user-level game program). In the particular VM used for development, all of these programs came pre-installed.

### Setup
1. Clone the repository
2. Modify the `SECRET_PATH` macro in [`driver/malwareDriver.c`](./driver/malwareDriver.c) as is appropriate
3. Modify the `TARGET_DIR` and `TARGET_FILES` macros in [`driver/malwareDriver.c`](./driver/malwareDriver.c) as is appropriate
4. Modify the configuration in [`cheat/supercheat.sh`](./cheat/supercheat.sh) to match `TARGET_DIR` and `TARGET_FILES`
5. Run the provided `install.sh` with root privileges

The kernel module is installed and removed with each double-click of the desktop icon.

 ### Exposing the `SECRET_PATH`
1. Double-click on the created desktop icon
2. Run `sudo dmesg` to view kernel output.

### Defeating the Anticheat Driver
1. Create one of the `TARGET_FILES` files in `TARGET_DIR`
2. Double-click on the desktop icon; observe that cheats were detected and game does not launch
3. Run the included `supercheat.sh` file; view that game launches regardless of the presence of known cheats

### Uninstall
The provided `uninstall.sh` script will clean any built files and remove the desktop icon.

## Demo
[https://youtu.be/iQ_irC6FyZw](https://youtu.be/iQ_irC6FyZw)

## References
* https://www.linuxjournal.com/article/8110
* https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
* https://linux.die.net/lkmpg/x769.html?fbclid=IwZXh0bgNhZW0CMTEAAR2TlYi6AaLVSdMU4sok29hE1F-Xi9BKjJQhm8Ll6SmVVzqCX2bK3ky2z0g_aem_JZueRPdglNZph6HAU2P0kQ
* https://elixir.bootlin.com/linux/v5.5.19/source

----
