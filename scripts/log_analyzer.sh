#!/bin/bash

LOG_FILE="/var/log/nginx/access.log"
REPORT_FILE="log_analysis_report.txt"

# Number of 404 errors
echo "Number of 404 errors:" > "$REPORT_FILE"
grep "404" "$LOG_FILE" | wc -l >> "$REPORT_FILE"

# Most requested pages
echo "Top 10 most requested pages:" >> "$REPORT_FILE"
awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -10 >> "$REPORT_FILE"

# IP addresses with the most requests
echo "Top 10 IP addresses with the most requests:" >> "$REPORT_FILE"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -10 >> "$REPORT_FILE"
