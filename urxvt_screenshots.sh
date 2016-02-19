#!/bin/bash
# script for taking screenshots of vim color schemes
geo=235x65+0+0
cSchemes=`find ~/ -ipath "*xcolors/themes/*"`
for currentScheme in $cSchemes
do
    echo "$currentScheme"
    sed -i "s|^#include.*|#include \"${currentScheme}\"|" ~/.Xresources 
    grep include ~/.Xresources
    xrdb ~/.Xresources
    urxvt --geometry $geo &
    pid=$!
    sleep 0.25  # VERY IMPORTANT for this gap for the window to form
    # sometimes the status bar wont apprear . Press 'j' to make it appear
    xdotool type --window `xwininfo -name "vim"| grep ' id'| awk '{print $4}' | xargs printf "%d\n"` "cd ~/Downloads"
    xdotool key --window `xwininfo -name "vim"| grep ' id'| awk '{print $4}' | xargs printf "%d\n"` Return
    sleep 0.25  # VERY IMPORTANT for this gap for the screenshot to capture
    xdotool type --window `xwininfo -name "vim"| grep ' id'| awk '{print $4}' | xargs printf "%d\n"` "ls"
    xdotool key --window `xwininfo -name "vim"| grep ' id'| awk '{print $4}' | xargs printf "%d\n"` Return
    sleep 0.25  # VERY IMPORTANT for this gap for the screenshot to capture
    scrot `basename ${currentScheme}`.png
    kill $pid
done
# rm vimCSscreenshots.tgz
# tar czf vimCSscreenshots.tgz *.png
# rm *.png
