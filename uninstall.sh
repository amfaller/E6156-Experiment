#!/bin/bash

# Ensure the script is running with root privileges
if [ "$(id -u)" -ne "0" ]; then
    echo "This script must be run as root!"
    exit 1
fi

# User and sudoers file path
USER="tony"
SUDOERS_FILE="/etc/sudoers"
SUDOERS_RULE="$USER ALL=(ALL) NOPASSWD: /sbin/insmod, /sbin/rmmod"

# Remove the NOPASSWD rule from sudoers
echo "Removing NOPASSWD rule from sudoers..."
sudo sed -i "\|$SUDOERS_RULE|d" "$SUDOERS_FILE"

echo "NOPASSWD rule removed."

# Clean the built files
DRIVER_DIR="./driver"

if [ -d "$DRIVER_DIR" ]; then
    echo "Running 'make clean' in the $DRIVER_DIR directory..."
    cd "$DRIVER_DIR" || { echo "Failed to change directory to $DRIVER_DIR"; exit 1; }
    make clean || { echo "'make clean' failed in $DRIVER_DIR"; exit 1; }
    echo "'make clean' completed successfully in $DRIVER_DIR."
    cd ..
else
    echo "Error: $DRIVER_DIR does not exist."
    exit 1
fi

# Remove the desktop icon
DESKTOP_ICON_PATH="/home/$USER/Desktop/LoadKernelModule.desktop"
rm -f $DESKTOP_ICON_PATH

