#!/bin/bash

# Input HTML file
HTML_FILE="IOC-1.html"

# Output file
OUTPUT_FILE="IOC.txt"

# Extract IOCs from HTML file
grep -oP '(?<=<td>).*?(?=</td>)' "$HTML_FILE" | sed -n '1~2p' > "$OUTPUT_FILE"

# Let user know that file was created
echo "IOC.txt file has been created"
