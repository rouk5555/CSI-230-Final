#!/bin/bash

# Input and output file names
REPORT_TXT="report.txt"
HTML_REPORT="/var/www/html/report.html"

# Create HTML report
{
    echo "<!DOCTYPE html>"
    echo "<html lang=\"en\">"
    echo "<head>"
    echo "    <meta charset=\"UTF-8\">"
    echo "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">"
    echo "    <title>IOC Report</title>"
    echo "    <style>"
    echo "        table { width: 100%; border-collapse: collapse; }"
    echo "        th, td { border: 1px solid black; padding: 8px; text-align: left; }"
    echo "        th { background-color: #f2f2f2; }"
    echo "    </style>"
    echo "</head>"
    echo "<body>"
    echo "    <h1>Access logs with IOC indicators:</h1>"
    echo "    <table>"
    echo "        <tr>"
    echo "            <th>IP Address</th>"
    echo "            <th>Date/Time</th>"
    echo "            <th>Page Accessed</th>"
    echo "        </tr>"

    # Read report.txt and convert each line to HTML table row
    while IFS= read -r line; do
        IP=$(echo "$line" | awk '{print $1}')
        DATETIME=$(echo "$line" | awk '{print $2}')
        PAGE=$(echo "$line" | awk '{$1=$2=""; print $0}' | sed 's/^ *//')
        echo "        <tr>"
        echo "            <td>$IP</td>"
        echo "            <td>$DATETIME</td>"
        echo "            <td>$PAGE</td>"
        echo "        </tr>"
    done < "$REPORT_TXT"

    echo "    </table>"
    echo "</body>"
    echo "</html>"
} > "/tmp/report.html"

# Move HTML report
sudo mv /tmp/report.html "$HTML_REPORT"

# Notify user of file creation
echo "HTML report file has been created"
