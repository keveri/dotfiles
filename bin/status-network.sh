#!/bin/sh

int_up=$(ip addr | grep 'state UP' -A 2)

ip_addr=$(echo "$int_up" | tail -n 1 | awk '{print $2}' | cut -f1 -d '/')
#int_name=$(echo "$int_up" | head -n 1 | awk '{print $2}' | cut -f1 -d ':')

echo "${ip_addr}"
