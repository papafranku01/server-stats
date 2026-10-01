#!/bin/bash

#CPU USAGE
sum=$(top -b -n 1 | awk 'NR > 7 {sum += $9} END {print sum}')
echo "Total CPU Usage: %$sum"

#MEMORY USAGE
usedMem=$(free | awk 'NR == 2 {print $3}')
freeMem=$(free | awk 'NR == 2 {print $4}')
totalMem=$(free | awk 'NR == 2 {print $2}')
percentUsed=$(awk -v u="$usedMem" -v t="$totalMem" 'BEGIN {printf "%.2f%%", u/t * 100}')
percentFree=$(awk -v f="$freeMem" -v t="$totalMem" 'BEGIN {printf "%.2f%%", f/t * 100}')
printf "\nTotal Memory Usage\nFree: %s (%s)\nUsed: %s (%s)\n" "$freeMem" "$percentFree" "$usedMem" "$percentUsed"

#DISK USAGE
rootUsed=$(df "/" | awk 'NR == 2 {print $3}')
rootFree=$(df "/" | awk 'NR == 2 {print $4}')
rootTotal=$(df "/" | awk 'NR ==2 {print $5}')
printf "\nTotal Disk Usage\nFree: %s\nUsed: %s (%s)\n" "$rootFree" "$rootUsed" "$rootTotal"

#PROCESS CPU USAGE BY 5
printf "\nProcesses by CPU usage:\n"
ps -eo pid,cmd,%cpu --sort=-%cpu | head -n 6

#PROCESS MEMORY USAGE BY 5
printf "\nProcesses by Memory usage:\n"
ps -eo pid,cmd,%mem --sort=-%mem | head -n 6

#OS NAME & VERSION
printf "\nOS Version: "
awk -F'"' 'NR==1 {print $2}' /etc/os-release

#WSL UPTIME
printf "\nWSL Uptime:"
uptime | awk -F ',' '{print $1}'

