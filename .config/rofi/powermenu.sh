#!/usr/bin/env bash

lock=" 󰌾 "
suspend=" 󰒲 "
logout=" 󰍃 "
reboot="  "
shutdown=" ⏻ "

options="$lock\n$suspend\n$logout\n$reboot\n$shutdown"
chosen="$(echo -e "$options" | rofi -dmenu -i -theme ~/.config/rofi/powermenu.rasi -p "Power:")"

case $chosen in
    $lock)
        ~/.config/hypr/lock_runner.sh
        ;;
    $suspend)
        systemctl suspend
        ;;
    $logout)
        ~/.config/hypr/exit_hyprland.sh
        ;;
    $reboot)
        systemctl reboot
        ;;
    $shutdown)
        systemctl poweroff
        ;;
esac
