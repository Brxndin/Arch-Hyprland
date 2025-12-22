#!/bin/bash
# Caminho para sua pasta de imagens
DIR=$HOME/wallpapers/workspace

while true; do
    # Escolhe uma imagem aleatória da pasta
    IMG=$(find "$DIR" -type f | shuf -n 1)
    # Aplica a imagem com uma transição legal
    swww img "$IMG" --transition-type grow --transition-duration 2
    # Espera 30 minutos (1800 segundos) antes de mudar de novo
    sleep 1800
done
