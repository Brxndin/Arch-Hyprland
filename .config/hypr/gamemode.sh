#!/bin/bash

# script que, ao ser ativado, serve para remover as animações e blur, melhorando a performance para jogos

# verifica se o blur está ativado (indica modo normal)
GAMEMODE=$(hyprctl getoption decoration:blur:enabled | grep 'bool: true')

if [ ! -z "$GAMEMODE" ] ; then
    # ATIVANDO GAME MODE

    # cria o arquivo de trava
    touch /tmp/gamemode_active

    # notificação
    notify-send "Gamemode" "Ativado: Efeitos visuais desligados" -i input-gaming

    # Desativa os efeitos do hyprland e das layers (waybar e rofi) com código Lua
    hyprctl eval '
        hl.config({
            decoration = {
                rounding = 0,
                active_opacity = 1.0,
                inactive_opacity = 1.0,
                drop_shadow = false,
                shadow = {
                    enabled = false
                },
                blur = {
                    enabled = false
                }
            },
            animations = {
                enabled = false
            }
        })

        hl.layer_rule({ name = "waybar-blur", match = { namespace = "waybar" }, blur = false })
        hl.layer_rule({ name = "rofi-blur", match = { namespace = "rofi" }, blur = false })
    '
    exit
fi

# DESATIVANDO GAME MODE

# remove o arquivo de trava
rm -f /tmp/gamemode_active

# notificação
notify-send "Gamemode" "Desativado: Efeitos visuais ligados" -i computer

hyprctl reload
