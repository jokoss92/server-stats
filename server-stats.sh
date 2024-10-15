#!/bin/bash

# Function to get total CPU usage
get_cpu_usage() {
    echo "Total CPU Usage:"
    top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4"%"}'
}

# Function to get total memory usage
get_memory_usage() {
    echo "Total Memory Usage (Free vs Used):"
    free -m | awk 'NR==2{printf "Used: %sMB / Total: %sMB (%.2f%%)\n", $3, $2, $3*100/$2}'
}

# Function to get total disk usage
get_disk_usage() {
    echo "Total Disk Usage (Free vs Used):"
    df -h --total | awk '$1 == "total" {printf "Used: %s / Total: %s (%s used)\n", $3, $2, $5}'
}

# Function to get top 5 processes by CPU usage
get_top_cpu_processes() {
    echo "Top 5 Processes by CPU Usage:"
    ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -n 6
}

# Function to get top 5 processes by memory usage
get_top_memory_processes() {
    echo "Top 5 Processes by Memory Usage:"
    ps -eo pid,ppid,cmd,%mem --sort=-%mem | head -n 6
}

# Optional: Function to get additional server info (OS version, uptime, load average, etc.)
get_additional_info() {
    echo "Additional System Information:"
    echo "OS Version:"; lsb_release -a 2>/dev/null
    echo "Uptime:"; uptime
    echo "Load Average:"; uptime | awk -F'load average:' '{ print $2 }'
    echo "Logged in Users:"; who
    echo "Failed Login Attempts:"; sudo grep "Failed password" /var/log/auth.log | wc -l
}

# Main script
echo "===== Server Performance Stats ====="
get_cpu_usage
echo ""
get_memory_usage
echo ""
get_disk_usage
echo ""
get_top_cpu_processes
echo ""
get_top_memory_processes
echo ""

# Optional additional stats
get_additional_info
