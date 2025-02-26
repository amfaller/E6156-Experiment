#!/bin/bash


PROC_FILE="/proc/ScanResults"

# Get the absolute path of this script
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
MODULE_PATH="$SCRIPT_DIR/malwareDriver.ko"
GAME_PATH="$SCRIPT_DIR/../game/game.sh"
CHEATER_PATH="$SCRIPT_DIR/../game/cheater.sh"

# Install the kernel driver
sudo insmod $MODULE_PATH

# Check the results of the "system" scan
if grep -q "Found target file" ${PROC_FILE}; then
    echo "Found known cheats; not launching game!"
    chmod +x "$CHEATER_PATH"
    "$CHEATER_PATH"
else
    echo "Launching program..."
    chmod +x $GAME_PATH
    "$GAME_PATH"
fi

# Clean up (remove driver)
sudo rmmod $MODULE_PATH

# TODO DELETE
read -p "Press any key" name
echo "Goodbye $name!"


