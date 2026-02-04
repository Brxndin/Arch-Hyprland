#!/bin/bash

UPDATES=$(checkupdates | wc -l)

if [ "$UPDATES" -gt 0 ]; then
    notify-send -a "Atualização" "Arch Linux" "$UPDATES pacotes disponíveis para atualização." -i software-update-available
fi
