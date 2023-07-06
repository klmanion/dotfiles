#!/bin/sh

xrdb -merge "$HOME/.Xresources"

xmodmap "$HOME/.Xmodmap"

setxkbmap -option ctrl:nocaps

synclient TapButton1=1

exec xmonad
