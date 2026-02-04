#!/bin/bash

DIR="$HOME/wallpapers/workspace"
CACHE_FILE="$HOME/.cache/hyprlock_colors.conf"

# busca imagem aleatória
# ignora gifs pois o hyprlock não funciona com eles
IMG=$(find "$DIR" -type f -iregex '.*\.\(png\|jpg\|jpeg\)' | shuf -n 1)
[ -z "$IMG" ] && exit 1

# calcula brilho
BRIGHTNESS=$(magick "$IMG" -colorspace Gray -format "%[fx:int(mean*255)]" info:)

# verifica se o brilho geral da imagem é maior ou menor que 128 e decide o contraste
if [ "$BRIGHTNESS" -gt 128 ]; then
    # fundo claro semi-transparente e texto escuro
    ACCENT="ff333333"      # Opaco (ff) + cinza escuro
    INPUT_BG="ccffffff"    # 80% alpha (cc) + branco
else
    # fundo escuro semi-transparente e texto branco
    ACCENT="ffffffff"      # Opaco (ff) + branco
    INPUT_BG="cc333333"    # 80% alpha (cc) + cinza escuro
fi

# salva as cores em variáveis num arquivo de cache
# tem o 0x na frente para indicar hexadecimal com opacidade
echo "\$accent = 0x$ACCENT" > "$CACHE_FILE"
echo "\$input_bg = 0x$INPUT_BG" >> "$CACHE_FILE"
echo "\$lock_wp = $IMG" >> "$CACHE_FILE"

# inicia o hyprlock
hyprlock
