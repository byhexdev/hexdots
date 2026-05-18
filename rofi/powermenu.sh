#!/usr/bin/env bash

chosen=$(printf "  Logout\n  Reboot\n  Shutdown" |
  rofi -dmenu -i -p "leaving?")

case "$chosen" in
"  Logout")
  hyprctl dispatch exit
  ;;
"  Reboot")
  systemctl reboot
  ;;
"  Shutdown")
  systemctl poweroff
  ;;
esac
