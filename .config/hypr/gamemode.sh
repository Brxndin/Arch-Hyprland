#!/bin/bash

# script que verifica se o blur e outros estilos estão ligados e desativa para melhor performance
HYPRGAMEMODE=$(hyprctl getoption decoration:blur:enabled | awk 'NR==1{print $2}')

if [ "$HYPRGAMEMODE" = 1 ] ; then
    hyprctl --batch "\
        keyword decoration:blur:enabled 0;\
        keyword decoration:drop_shadow 0;\
        keyword decoration:rounding 0;\
        keyword decoration:active_opacity 1.0;\
        keyword decoration:inactive_opacity 1.0;\
        keyword layerrule \"unset, waybar\";\
        keyword layerrule \"unset, wofi\";\
        keyword animations:enabled 0"
    exit
fi
hyprctl reload
