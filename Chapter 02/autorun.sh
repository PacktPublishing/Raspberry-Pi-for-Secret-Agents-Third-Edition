#!/bin/sh
#
# Auto-run script for Raspberry Pi.
# Use chmod +x ~/autorun.sh to enable.

PLAYORREC=P # Set to P for Playback or R for Record

INPUTFILE="playme.wav"
OUTPUTFILE="myrec.wav"
MICROPHONE="-t alsa plughw:1"
SPEAKERS="-t alsa plughw:0"

case "$PLAYORREC" in
  P|p) sox ~/"$INPUTFILE" $SPEAKERS ;;
  R|r) sox $MICROPHONE ~/"$OUTPUTFILE" ;;
  *) echo "Set the PLAYORREC variable to P for Playback or R for Record" ;;
esac
