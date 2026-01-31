#!/bin/bash

# script que, ao ser ativado, serve para remover as animações e blur, melhorando a performance para jogos

# verifica se o blur está ativado (indica modo normal)
HYPRGAMEMODE=$(hyprctl getoption decoration:blur:enabled | awk 'NR==1{print $2}')

if [ "$HYPRGAMEMODE" = 1 ] ; then
    # ATIVANDO GAME MODE

    # cria o arquivo de trava
    touch /tmp/gamemode_active
    
    # notificação
    notify-send "Gamemode" "Ativado: Efeitos visuais desligados" -i input-gaming

    hyprctl --batch "\
        keyword decoration:blur:enabled 0;\
        keyword decoration:drop_shadow 0;\
        keyword decoration:rounding 0;\
        keyword decoration:active_opacity 1.0;\
        keyword decoration:inactive_opacity 1.0;\
        keyword layerrule \"unset, waybar\";\
        keyword layerrule \"unset, rofi\";\
        keyword animations:enabled 0"
    exit
fi

# DESATIVANDO GAME MODE

# remove o arquivo de trava
rm -f /tmp/gamemode_active

# notificação
notify-send "Gamemode" "Desativado: Efeitos visuais ligados" -i computer

hyprctl reload
