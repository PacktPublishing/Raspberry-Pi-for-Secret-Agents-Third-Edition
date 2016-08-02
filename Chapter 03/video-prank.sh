#!/bin/sh
#
# Raspberry Pi Video Prank Script
# Use chmod +x ~/autorun.sh to enable.

CREEPY_MOVIE="AJn5Y65GAkA.mp4" # Creepy movie to play, located in the Pi home directory

MOVIE_LOOPS="1" # Number of times to play creepy movie (1 by default)

MOVIE_SLEEP="3600" # Number of seconds to sleep between movie plays (1 hour by default)

WEBCAM_PRANK="y" # Set to y to enable the motion detection prank

tv_off() {
  if [ "$(echo "pow 0" | cec-client -d 1 -s | grep 'power status: 
    on')" ]; then # If TV is currently on
  echo "standby 0" | cec-client -d 1 -s # Send the standby command
  fi
}

prepare_tv() {
  tv_off # We switch the TV off and on again to force the 
    active channel to the Pi
  sleep 10 # Give it a few seconds to shut down
  echo "on 0" | cec-client -d 1 -s # Now send the on command
  sleep 10 # And give the TV another few seconds to wake up
  echo "as" | cec-client -d 1 -s # Now set the Pi to be the 
    active source
}

play_movie() {
  if [ -f ~/"$CREEPY_MOVIE" ]; then # Check that the creepy movie 
    file exists
  omxplayer -o hdmi ~/"$CREEPY_MOVIE" # Then play it with sound 
    going out through HDMI
  fi
}


case "$1" in
  prankon) # Signal from Motion that event has started
    prepare_tv
    play_movie
    tv_off
    ;;

  prankoff) # Signal from Motion that event has ended
    ;;

  *) # Normal start up of autorun.sh script
for i in $(seq $MOVIE_LOOPS) # Play creepy movie in a loop the number of times specified
do
prepare_tv
   play_movie
   tv_off
   sleep "$MOVIE_SLEEP" # Sleep the number of seconds specified
done

    start_webcam_prank # Begin prank phase 2
    ;;
esac
