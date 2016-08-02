#!/bin/sh
DEV_MAC="00:03:89:93:8D:B4" #mac addr of headset
echo "power on" | bluetoothctl -a
echo "agent on" | bluetoothctl -a
echo "connect $DEV_MAC" | bluetoothctl -a
echo "exit" | bluetoothctl -a
