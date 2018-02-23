#!/bin/sh
output_states=4

# if we don't have a file, start at zero
if [ ! -f "/tmp/i3wm-output-state.dat" ] ; then
  state=0
# otherwise read the state from the file
else
  state=`cat /tmp/i3wm-output-state.dat`
fi

# increment the state
state=`expr ${state} + 1`
if [[ state -ge output_states ]] ; then
  state=0
fi

message=""

case $state in
  [0]*)
  message="LVDS1 auto"
  xrandr --output LVDS1 --auto --gamma 0.8:0.8:0.8 --output HDMI1 --off --output --VGA1 --off
  ;;
  [1]*)
  xrandr --fb 1920x1080 --output LVDS1 --mode 1366x768 --scale-from 1920x1080 --gamma 0.8:0.8:0.8 --output HDMI1 --mode 1920x1080 --scale 1x1 --same-as LVDS1
  ;;
  [2]*)
  message="HDMI1 auto"
  xrandr --output LVDS1 --off --output HDMI1 --auto --output --VGA1 --off
  ;;
  [3]*)
  message="LVDS1 auto | HDMI1 auto, right of LVDS1"
  xrandr --output LVDS1 --auto --gamma 0.8:0.8:0.8 --output HDMI1 --auto --right-of LVDS1
  ;;
esac

echo message
notify-send "Video output changed" "$message"

echo "${state}" > /tmp/i3wm-output-state.dat
