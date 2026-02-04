#!/bin/bash

# Monitora mudanças e envia notificação
playerctl metadata --format '{{ title }} - {{ artist }}' --follow | while read line; do
    # Verifica se a linha não está vazia para evitar notificações fantasmas
    if [ ! -z "$line" ]; then
        notify-send -a "Spotify" "Tocando Agora" "$line" -i spotify
    fi
done
