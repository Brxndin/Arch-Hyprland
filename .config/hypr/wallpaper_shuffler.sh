#!/bin/bash
# Caminho para sua pasta de imagens
DIR=$HOME/wallpapers/workspace

while true; do
    # Escolhe uma imagem aleatória da pasta
    IMG=$(find "$DIR" -type f | shuf -n 1)
    
    # Aplica a imagem com uma transição legal
    swww img "$IMG" --transition-type grow --transition-duration 2
    
    # pega o esquema de cores com o pywal
    wal -i "$IMG" -n

    # Recarrega a Waybar (mata a antiga e inicia uma nova)
    # faz isso para atualizar as cores dinamicamente
    killall waybar && waybar &
    
    # Espera 10 minutos (600 segundos) antes de mudar de novo
    sleep 600
done
