#!/bin/bash

PROC_FILE="/proc/ScanResults"

# Get the absolute path of this script
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Install the kernel driver
MODULE_PATH="$SCRIPT_DIR/malwareDriver.ko"
sudo insmod $MODULE_PATH


# Check the results of the "system" scan
if grep -q "Found target file" ${PROC_FILE}; then
    echo "Found known cheats; not launching game!"
else
    echo "Launching program..."
    firefox
fi

# Clean up (remove driver)
sudo rmmod $MODULE_PATH

# TODO DELETE
read -p "Press any key" name
echo "Goodbye $name!"


