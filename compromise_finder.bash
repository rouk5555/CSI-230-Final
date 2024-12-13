#!/bin/bash

# File names
LOG_FILE="access.log"
IOC_FILE="IOC.txt"
OUTPUT_FILE="report.txt"


# Read IOCs from IOC file and filter logs
while IFS= read -r IOC; do
    grep "$IOC" "$LOG_FILE" | awk '{print $1, $4, $7}' | sed -E 's/\[//;s/\]//'  >> "$OUTPUT_FILE"
done < "$IOC_FILE"

# Let user know that file was created
echo "report.txt file has been created"
