#!/bin/bash
for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*; do
    scaling_governor_file="$cpu_dir/cpufreq/scaling_governor"
    if [ -f "$scaling_governor_file" ]; then
         echo "performance" > "$scaling_governor_file"
         echo "Updated $scaling_governor_file to 'performance'."
    else
         echo "Skipping $cpu_dir as scaling_governor file does not exist."
    fi
done
