#!/bin/bash

if pgrep -x "wlsunset" > /dev/null
then
    pkill wlsunset > /dev/null 2>&1
else
    wlsunset -T 4200 > /dev/null 2>&1 &
fi
