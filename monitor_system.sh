#!/bin/bash
# Monitoring script for Ubuntu 22.04 with email alerts

LOGFILE="/var/log/system_monitor.log"
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
ADMIN_EMAIL="youremail@email.com"

# Thresholds
CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=80
IO_THRESHOLD=80
NETWORK_THRESHOLD=1000

# Function to send email alert
send_alert() {
    local subject=$1
    local message=$2
    echo -e "$message" | mail -s "$subject" $ADMIN_EMAIL
}

# Check CPU usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
    send_alert "CPU Usage Alert" "CPU usage is at ${CPU_USAGE}% as of $TIMESTAMP"
fi

# Check Memory usage
MEMORY_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
if (( $(echo "$MEMORY_USAGE > $MEMORY_THRESHOLD" | bc -l) )); then
    send_alert "Memory Usage Alert" "Memory usage is at ${MEMORY_USAGE}% as of $TIMESTAMP"
fi

# Check Disk usage
DISK_USAGE=$(df / | grep / | awk '{print $5}' | sed 's/%//g')
if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
    send_alert "Disk Usage Alert" "Disk usage is at ${DISK_USAGE}% as of $TIMESTAMP"
fi

# Check I/O statistics (using iostat for checking iowait)
IO_WAIT=$(iostat | awk 'NR==4 {print $4}')
if (( $(echo "$IO_WAIT > $IO_THRESHOLD" | bc -l) )); then
    send_alert "I/O Wait Alert" "I/O wait is at ${IO_WAIT}% as of $TIMESTAMP"
fi

# Check Network usage (this example assumes threshold is in packets/s)
NETWORK_RX=$(netstat -i | grep -vE 'Iface|lo' | awk '{print $4}' | tail -n +2)
NETWORK_TX=$(netstat -i | grep -vE 'Iface|lo' | awk '{print $8}' | tail -n +2)
NETWORK_USAGE=$((NETWORK_RX + NETWORK_TX))
if [ "$NETWORK_USAGE" -gt "$NETWORK_THRESHOLD" ]; then
    send_alert "Network Usage Alert" "Network usage is at ${NETWORK_USAGE} packets/s as of $TIMESTAMP"
fi

# Logging the results
echo "System Monitoring Report - $TIMESTAMP" > $LOGFILE

echo -e "\n### CPU and Memory Usage ###" >> $LOGFILE
top -b -n 1 | head -n 20 >> $LOGFILE

echo -e "\n### Memory Usage ###" >> $LOGFILE
free -h >> $LOGFILE

echo -e "\n### Disk Usage ###" >> $LOGFILE
df -h >> $LOGFILE

echo -e "\n### I/O Statistics ###" >> $LOGFILE
iostat >> $LOGFILE

echo -e "\n### Network Statistics ###" >> $LOGFILE
netstat -i >> $LOGFILE

echo -e "\n### End of Report ###" >> $LOGFILE

# Display message
echo "System monitoring report saved to $LOGFILE"
