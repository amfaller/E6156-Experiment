#!/bin/bash

# Get the absolute path of this script
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Install the kernel driver
MODULE_PATH="$SCRIPT_DIR/malwareDriver.ko"
sudo insmod $MODULE_PATH

# TODO: Launch snake or something

# Clean up (remove driver)
sudo rmmod $MODULE_PATH


