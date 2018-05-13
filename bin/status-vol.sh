#!/bin/sh

master_vol=$(amixer get Master)

vol=$(echo "$master_vol" | awk '$0~/%/{print $5}' | head -n 1 | tr -d '[]%')
mute_status=$(echo "$master_vol" | awk '$0~/%/{print $6}' | head -n 1)

echo "Vol: ${vol} ${mute_status}"
