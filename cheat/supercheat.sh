#!/bin/bash

# Configuration
TARGET_DIR="/home/tony/Documents"
TARGET_FILE="cheat1.txt"
ORIGINAL_SCRIPT="../driver/load.sh"
TEMP_SUFFIX="_temp_$(date +%s)"

# Randomize the filename
TEMP_FILE="${TARGET_FILE}${TEMP_SUFFIX}"
mv "${TARGET_DIR}/${TARGET_FILE}" "${TARGET_DIR}/${TEMP_FILE}"
echo "Renamed ${TARGET_FILE} to ${TEMP_FILE}"

# Call the original load script to mimic the game
${ORIGINAL_SCRIPT}

# Restore the original filename
mv "${TARGET_DIR}/${TEMP_FILE}" "${TARGET_DIR}/${TARGET_FILE}" 
echo "Restored ${TEMP_FILE} to ${TARGET_FILE}"
