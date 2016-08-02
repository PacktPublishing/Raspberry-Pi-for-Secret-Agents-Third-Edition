#!/bin/bash
# Raspberry Pi for Secret Agents - 3rd Ed
# Matthew Poole - http://cubiksoundz.com

MAC="60:f1:89:85:5b:ec" #MAC address to find
FILEPATH="/home/pi/wifiscan.txt"
WIFI="wlan0"

#set up wifi device for monitoring
sudo ifconfig $WIFI down
sudo iwconfig $WIFI mode monitor
sudo ifconfig $WIFI up

while true
do
  #scan wifi probe requests
  echo "Scanning..."
  sudo tshark -i $WIFI -n -a duration:15 -f "ether host $MAC" > $FILEPATH

  #get number of times found - case insensitive
  FOUND=$(grep -ci $MAC $FILEPATH)
  echo "Result: $FOUND"

  if [ $FOUND -gt 0 ]; then
    #device found
    echo "DEVICE FOUND"
  else
    #device not found
    echo "DEVICE NOT FOUND"
  fi
done
