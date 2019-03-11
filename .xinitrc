#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Keyboard
if [[ -n $(which setxkbmap) ]]; then
    setxkbmap -layout "us,ru(winkeys)" \
    -option "ctrl:nocaps,grp:toggle,grp_led:caps,terminate:ctrl_alt_bksp"
fi

if [[ -n $(which xcape) ]]; then
  xcape -t 1000 -e "Control_L=Escape"
fi

# DE
wicd-client -t &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
exec awesome
