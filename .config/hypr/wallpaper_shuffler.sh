#!/bin/bash

# caminho para pasta de imagens
DIR=$HOME/wallpapers/workspace

while true; do
    # se o gamemode estiver ativo, não faz nada
    if [ -f "/tmp/gamemode_active" ]; then
        sleep 600
        continue
    fi

    # escolhe uma imagem aleatória da pasta
    IMG=$(find "$DIR" -type f | shuf -n 1)
    
    # aplica a imagem com uma transição legal
    swww img "$IMG" --transition-type grow --transition-duration 2
    
    # pega o esquema de cores com o pywal
    wal -i "$IMG" -n

    # atualiza o Mako através de template do pywal
    # verifica se o arquivo existe antes de copiar para evitar erros
    if [ -f "$HOME/.cache/wal/mako-config" ]; then
        cp "$HOME/.cache/wal/mako-config" "$HOME/.config/mako/config"
        makoctl reload
    fi

    # recarrega o CSS da Waybar
    # para atualizar as cores dinamicamente
    killall -SIGUSR2 waybar

    # espera 10 minutos (600 segundos) antes de tentar mudar de novo
    sleep 600
done
