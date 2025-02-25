# E6156-Experiment
This repository contains the source code for a small-scale experiment. This supports the midterm paper in E6156: Topics in Software Engineering (Spring 2025).

Author: Tony Faller (af3370@columbia.edu)

## :warning: WARNING :warning:
The code in this repository closely emulates kernel-level malware. Proceed at your own risk.

## General
The idea behind this experiment is to demonstrate the dangers of third-party kernel access. At a surface level, running the included `install.sh` script will create a desktop icon which appears to be a web browser; indeed, when this icon is double clicked, Firefox opens and is fully functional.

However, hidden from the user is the installation of the kernel module located in the [`driver`](./driver) directory. This module reads a file (hardcoded to `/home/tony/Documents/mySecret.txt`) and simply prints to kernel output. One can imagine this extending to reading all files in a given system and publishing data via the network, which is a major invasion of privacy completely hidden from the user.

## Getting Started
This experiment was developed on a virtual machine (VM) running Ubuntu 24.10. The only required dependencies are `git` (to clone the repo), `make`, and `gcc-14` (both to build the kernel module). This experiment also assumes that `firefox` can be run from the command line.

1. Clone the repository
2. Modify the `SECRET_PATH` macro in [`driver/malwareDriver.c`](./driver/malwareDriver.c) to point at an appropraite file
3. Run the provided `install.sh` with root privileges
4. Double-click on the created desktop icon
5. Run `sudo dmesg` to view kernel output.

The kernel module is installed and removed with each double-click of the desktop icon.

### Uninstall
The provided `uninstall.sh` script will clean any built files and remove the desktop icon.

## Demo
[https://youtu.be/OXoeEqkWB4U](https://youtu.be/OXoeEqkWB4U)

## References
* https://www.linuxjournal.com/article/8110
* https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script

----
