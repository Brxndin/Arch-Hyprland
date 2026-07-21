#!/bin/bash

# mata os scripts personalizados
pkill -f wallpaper_shuffler.sh
pkill -f spotify_notify.sh
pkill -f check_updates.sh

# mata os daemons e aplicativos de fundo
killall awww-daemon
killall wob
killall wl-paste
killall waybar
killall mako
killall hypridle
killall nm-applet
killall blueman-applet
killall playerctld

# comando oficial de saída do Hyprland
hyprctl dispatch "hl.dsp.exit()"
