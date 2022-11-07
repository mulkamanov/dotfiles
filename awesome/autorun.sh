#!/bin/sh

run() {
    if ! pgrep -f "$1";
    then
        "$@"&
    fi
}

run nm-applet
run xfce4-power-manager
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
run /usr/bin/ideapad-perf-tray.rb
run pcmanfm -d
