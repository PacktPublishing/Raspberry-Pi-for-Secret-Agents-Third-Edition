#!/bin/bash
# Raspberry Pi for Secret Agents - 3rd Ed
# Matthew Poole - http://cubiksoundz.com

sudo echo 17 > /sys/class/gpio/export
sudo echo in > /sys/class/gpio/gpio17/direction

# loop forever
while true
do
  # read the beam state
  BEAM=$(sudo cat /sys/class/gpio/gpio17/value)

  if [ $BEAM == 1 ]; then
    #beam not blocked
    echo "OK"

  else
    #beam was broken
    echo "ALERT"
  
  fi
done
