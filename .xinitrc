#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# Set right ctrl as compose key
setxkbmap -option compose:rctrl
# Remap caps lock to escape
setxkbmap -option caps:escape

[[ -f $userresources ]] && xrdb -merge $userresources

exec bspwm 

