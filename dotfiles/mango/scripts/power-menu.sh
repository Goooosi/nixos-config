#!/usr/bin/env bash
choice=$(printf 'Lock\nLogout\nSuspend\nReboot\nShutdown\n' | tofi --prompt-text "power: ")

case "$choice" in
  Lock)     swaylock -f ;;
  Logout)   mmsg -d quit ;;
  Suspend)  systemctl suspend ;;
  Reboot)   systemctl reboot ;;
  Shutdown) systemctl poweroff ;;
esac
