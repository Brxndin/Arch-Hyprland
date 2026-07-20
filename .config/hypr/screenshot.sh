#!/bin/bash

mkdir -p ~/screenshots

FILE=~/screenshots/$(date +'%Y-%m-%d_%Hh%Mm%Ss')_screenshot.png

# só salva se não for cancelado
if grim -g "$(slurp)" "$FILE"; then
    # abre a imagem no Drawing para edição
    drawing "$FILE" &
    
    # Envia a notificação
    notify-send -a "Sistema" "Screenshot Salva" "Imagem salva em ~/screenshots" -i "$FILE"
else
    # Notificação em caso de cancelamento do print
    notify-send -a "Sistema" "Aviso" "Captura de tela cancelada."
fi
