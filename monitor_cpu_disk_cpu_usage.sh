#!/bin/bash

# Set thresholds for alerting
THRESHOLD_DISK=80
THRESHOLD_RAM=75
THRESHOLD_CPU=70

# Get current usage statistics
DISK_USAGE=$(df / | grep / | awk '{print $5}' | sed 's/%//g')
RAM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')

# Logging the usage data
echo "$(date '+%Y-%m-%d %H:%M:%S') CPU: $CPU_USAGE% RAM: $RAM_USAGE% Disk: $DISK_USAGE%" >> /var/log/system_monitor.log

# Check if usage exceeds thresholds and send alert
if [ "$DISK_USAGE" -gt "$THRESHOLD_DISK" ]; then
    echo "Disk usage is above $THRESHOLD_DISK%! Current usage: $DISK_USAGE%" | mail -s "Disk Usage Alert" admin@example.com
fi

if (( $(echo "$RAM_USAGE > $THRESHOLD_RAM" | bc -l) )); then
    echo "RAM usage is above $THRESHOLD_RAM%! Current usage: $RAM_USAGE%" | mail -s "RAM Usage Alert" admin@example.com
fi

if (( $(echo "$CPU_USAGE > $THRESHOLD_CPU" | bc -l) )); then
    echo "CPU usage is above $THRESHOLD_CPU%! Current usage: $CPU_USAGE%" | mail -s "CPU Usage Alert" admin@example.com
fi
