#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Keyboard stuff

## Set right ctrl as compose key
setxkbmap -option compose:rctrl

## Remap caps lock to escape
setxkbmap -option caps:escape

# Set key repeat rate
xset r rate 200 25

[[ -f $userresources ]] && xrdb -merge $userresources

exec bspwm 

