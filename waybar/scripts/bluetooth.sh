#!/bin/bash

# Check if Bluetooth is powered on
if [ $(bluetoothctl show | grep "Powered: yes" | wc -l) -eq 0 ]; then
  echo '{"text": "", "tooltip": "Bluetooth: Off", "class": "disabled"}'
else
  devices_paired=$(bluetoothctl devices Paired | awk '{print $2}')
  connected=false
  
  for device in $devices_paired; do
    if [ $(bluetoothctl info "$device" | grep "Connected: yes" | wc -l) -eq 1 ]; then
      device_alias=$(bluetoothctl info "$device" | grep "Alias" | cut -d ' ' -f 2-)
      
      # Extract battery percentage if available
      battery_percent=$(bluetoothctl info "$device" | grep "Battery Percentage" | awk -F '[()]' '{print $2}')
      
      if [ -n "$battery_percent" ]; then
        # If battery info exists, show icon + battery % on the bar
        echo "{\"text\": \"\", \"tooltip\": \"Connected to: $device_alias ($battery_percent% Battery)\", \"class\": \"connected\"}"
      else
        # If no battery info is reported by the device
        echo "{\"text\": \"\", \"tooltip\": \"Connected to: $device_alias\", \"class\": \"connected\"}"
      fi
      
      connected=true
      break
    fi
  done
  
  if [ "$connected" = false ]; then
    echo '{"text": "", "tooltip": "Bluetooth: On (Disconnected)", "class": "disconnected"}'
  fi
fi
