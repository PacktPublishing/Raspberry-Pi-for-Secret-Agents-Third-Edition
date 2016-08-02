#!/bin/bash
#
# Noise activated recorder script for Raspberry Pi.
# Use chmod +x ~/noisedetect.sh to enable.

THRESHOLD=0.010000

noise_compare() {
  awk -v NOISE=$1 -v THRESHOLD=$2 'BEGIN {if (NOISE > THRESHOLD) exit 0; exit 1}'
}

while true ; do
  NOISE=$(sox -t alsa plughw:1 -n stat trim 0 00:00:01 2>&1 > /dev/null | grep 'Maximum amplitude' | cut -d ':' -f 2 | tr -d ' ')
  if noise_compare $NOISE $THRESHOLD; then
    echo "Noise detected ($NOISE) - Recording..."
    sox -t alsa plughw:1 $(date +%Y%m%d-%H%M%S).wav trim 0 00:05:00
  fi
done
