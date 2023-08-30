#!/bin/bash

Xvfb :1 -screen 0 850x700x16 &
/usr/bin/x11vnc -display :1.0 -usepw -forever &
DISPLAY=:1.0
export DISPLAY
java -jar RAID\ Admin\ 1.5.1/RAID_Admin.jar