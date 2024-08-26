#!/bin/bash

# Set threshold values
CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=80

# Check CPU usage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
if (( $(echo "$cpu_usage > $CPU_THRESHOLD" | bc -l) )); then
    echo "Warning: CPU usage is above threshold! Current usage: $cpu_usage%" | tee -a system_health.log
fi

# Check Memory usage
memory_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
if (( $(echo "$memory_usage > $MEMORY_THRESHOLD" | bc -l) )); then
    echo "Warning: Memory usage is above threshold! Current usage: $memory_usage%" | tee -a system_health.log
fi

# Check Disk usage
disk_usage=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')
if [ $disk_usage -gt $DISK_THRESHOLD ]; then
    echo "Warning: Disk usage is above threshold! Current usage: $disk_usage%" | tee -a system_health.log
fi

# List top 5 processes by memory usage
echo "Top 5 memory consuming processes:" | tee -a system_health.log
ps aux --sort=-%mem | awk 'NR<=5{print $0}' | tee -a system_health.log
