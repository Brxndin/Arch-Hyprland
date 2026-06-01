#!/bin/bash

DIR="$HOME/wallpapers/workspace"
CACHE_FILE="$HOME/.cache/hyprlock_colors.conf"

# busca imagem aleatória
# ignora gifs pois o hyprlock não funciona com eles
IMG=$(find "$DIR" -type f -iregex '.*\.\(png\|jpg\|jpeg\)' | shuf -n 1)
[ -z "$IMG" ] && exit 1

# fundo escuro semi-transparente e texto branco
ACCENT="ffffffff"      # Opaco (ff) + branco
INPUT_BG="cc333333"    # 80% alpha (cc) + cinza escuro

# salva as cores em variáveis num arquivo de cache
# tem o 0x na frente para indicar hexadecimal com opacidade
echo "\$accent = 0x$ACCENT" > "$CACHE_FILE"
echo "\$input_bg = 0x$INPUT_BG" >> "$CACHE_FILE"
echo "\$lock_wp = $IMG" >> "$CACHE_FILE"

# inicia o hyprlock
hyprlock
