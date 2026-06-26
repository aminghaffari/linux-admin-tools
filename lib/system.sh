#!/bin/bash

cpu_cores() {
    nproc
}

load_average() {
    awk '{print $1" "$2" "$3}' /proc/loadavg
}

uptime_pretty() {
    uptime -p
}

memory_total() {
    free -h | awk '/Mem:/ {print $2}'
}

memory_used() {
    free -h | awk '/Mem:/ {print $3}'
}

memory_available() {
    free -h | awk '/Mem:/ {print $7}'
}

swap_total() {
    free -h | awk '/Swap:/ {print $2}'
}

swap_used() {
    free -h | awk '/Swap:/ {print $3}'
}

disk_usage() {
    df -h \
      -x tmpfs \
      -x devtmpfs \
      --output=source,pcent,target | tail -n +2
}

top_cpu_process() {
    ps -eo pid,user,%cpu,%mem,etime,args --sort=-%cpu | awk '
    NR==1 {next}
    $6 !~ /^ps$/ && $6 !~ /^awk$/ && $6 !~ /^grep$/ {print; exit}
    '
}
top_memory_process() {
    ps -eo pid,user,%mem,%cpu,etime,args --sort=-%mem | awk '
    NR==1 {next}
    $6 !~ /^ps$/ && $6 !~ /^awk$/ && $6 !~ /^grep$/ {print; exit}
    '
}

failed_services() {
    systemctl --failed --no-legend 2>/dev/null
}
memory_usage_percent() {
    free | awk '/Mem:/ {printf "%.0f", ($3/$2)*100}'
}

highest_disk_usage() {
    df -P -x tmpfs -x devtmpfs | awk 'NR>1 {gsub("%","",$5); if($5>max) max=$5} END {print max+0}'
}

load_average_1m() {
    awk '{print $1}' /proc/loadavg
}
