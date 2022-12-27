#!/bin/sh

xrdb -merge "$HOME/.Xresources"

xmodmap "$HOME/.Xmodmap"

setxkbmap -option ctrl:nocaps

exec xmonad
