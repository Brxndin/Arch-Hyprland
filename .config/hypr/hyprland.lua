-- VARIAVEIS NVIDIA
-- Algumas configurações são específicas para a GPU funcionar melhor
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("TERMINAL", "kitty")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("XCURSOR_THEME", "capitaine-cursors")
hl.env("XCURSOR_SIZE", "32")
hl.env("HYPRCURSOR_THEME", "capitaine-cursors")
hl.env("HYPRCURSOR_SIZE", "32")

-- TECLADO E MOUSE
hl.config({
    input = {
        kb_layout = "br",
        follow_mouse = 1,
        sensitivity = 0,
    }
})

-- DESATIVA WALLPAPERS PADRÃO e CONFIGURAÇÕES DIVERSAS
hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        vrr = 1, -- necessário para o g-sync
    }
})

-- AUTOSTART
hl.on("hyprland.start", function () 
    -- Layout / Wallpaper (O awww e o script dependem disso pra funcionar as cores)
    hl.exec_cmd("awww-daemon &")
    hl.exec_cmd("~/.config/hypr/wallpaper_shuffler.sh &")
    
    -- Autostart Programs
    hl.exec_cmd("rm -f $XDG_RUNTIME_DIR/wob.sock && mkfifo $XDG_RUNTIME_DIR/wob.sock && tail -f $XDG_RUNTIME_DIR/wob.sock | wob &")
    hl.exec_cmd("wl-paste --type text --watch cliphist store &")
    hl.exec_cmd("wl-paste --type image --watch cliphist store &")
    hl.exec_cmd("cliphist wipe")
    hl.exec_cmd("waybar &")
    hl.exec_cmd("mako &")
    hl.exec_cmd("hypridle &")
    hl.exec_cmd("nm-applet --indicator &")
    hl.exec_cmd("blueman-applet &")
    
    -- Scripts
    hl.exec_cmd("playerctld daemon")
    hl.exec_cmd("~/.config/hypr/spotify_notify.sh &")
    hl.exec_cmd("sleep 10 && ~/.config/hypr/check_updates.sh &")
end)

-- IMPORTANDO CORES DO PYWAL

-- Carrega o arquivo gerado pelo Pywal
local colors = dofile(os.getenv("HOME") .. "/.cache/wal/colors-hyprland.lua")

hl.config({
    general = {
        border_size = 2,
        col = {
            -- Agora você usa a tabela 'colors' para puxar a cor exata
            active_border = colors.color4 .. "ee",
            inactive_border = colors.color0 .. "aa",
        },
    },

    dwindle = {
        preserve_split = true,
    },

    decoration = {
        active_opacity = 0.9,
        inactive_opacity = 0.8,
        
        blur = {
            enabled = true,
            size = 8,
            passes = 2,
        },
    },

    animations = {
        enabled = true,
    },
})

-- CURVAS E ANIMAÇÕES
hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })
hl.curve("fluent", { type = "bezier", points = { {0.1, 1},    {0, 1} } })

hl.animation({ leaf = "windows", enabled = true, speed = 7,  bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7,  bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7,  bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6,  bezier = "fluent" })


-- REGRAS DE MONITORES / WORKSPACES ESPECÍFICOS
hl.monitor({ output = "DP-1", mode = "preferred", position = "auto", scale = "auto" })
hl.monitor({ output = "DP-2", mode = "preferred", position = "auto", scale = "auto" })

-- Esquerda
hl.workspace_rule({ workspace = "1", monitor = "DP-1" })
hl.workspace_rule({ workspace = "2", monitor = "DP-1" })
hl.workspace_rule({ workspace = "3", monitor = "DP-1" })
hl.workspace_rule({ workspace = "4", monitor = "DP-1" })
hl.workspace_rule({ workspace = "5", monitor = "DP-1" })

-- Direita
hl.workspace_rule({ workspace = "6", monitor = "DP-2" })
hl.workspace_rule({ workspace = "7", monitor = "DP-2" })
hl.workspace_rule({ workspace = "8", monitor = "DP-2" })
hl.workspace_rule({ workspace = "9", monitor = "DP-2" })
hl.workspace_rule({ workspace = "10", monitor = "DP-2" })


-- REGRAS DE JANELAS (LAYER RULES)
hl.layer_rule({ name = "rofi-blur", match = { namespace = "rofi" }, blur = true })
hl.layer_rule({ name = "waybar-blur", match = { namespace = "waybar" }, blur = true })

-- REGRAS DE JANELAS (WINDOW RULES)
-- Correção para arrastar janelas no XWayland
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

hl.window_rule({ name = "thunar-rules", match = { class = "thunar" }, opacity = "0.8 0.8", float = true, size = "1000 700" })
hl.window_rule({ name = "nwg-look-float", match = { class = "nwg-look" }, float = true })
hl.window_rule({ name = "blueman-float", match = { class = "blueman-manager" }, float = true })
hl.window_rule({ name = "hyprpwcenter-float", match = { class = "hyprpwcenter" }, float = true })
hl.window_rule({ name = "drawing-float", match = { title = "Drawing" }, float = true })


-- ATALHOS BÁSICOS
local mainMod = "SUPER"

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
-- verificar se funciona
-- basicamente mata os script que foram acionados no autostart
-- hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("pkill -f wallpaper_shuffler.sh; pkill -f awww-daemon; hyprctl dispatch exit"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("thunar"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
-- hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("hyprctl dispatch centerwindow"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("~/.config/hypr/gamemode.sh"))
hl.bind(mainMod .. " + H", hl.dsp.exec_cmd("cliphist list | rofi -dmenu -p '󰆏' | cliphist decode | wl-copy"))

-- Atalho do Print
hl.bind("Print", hl.dsp.exec_cmd("~/.config/hypr/screenshot.sh"))

-- INTERAÇÃO DO MOUSE COM JANELAS
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })


-- FOCO DO WORKSPACE E MOVIMENTAÇÃO DE JANELAS (1 a 10)
-- A configuração em Lua permite utilizar um "for loop" para encurtar drasticamente as declarações
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- SPECIAL WORKSPACES PARA GUARDAR JANELAS
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- LOCK
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("~/.config/hypr/lock_runner.sh"))

-- BARRA DE VOLUME E COMANDOS DE MÍDIA
-- O antigo 'binde' do Hyprland é traduzido no Lua adicionando a tabela '{ repeating = true }'
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ && wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2*100}' > $XDG_RUNTIME_DIR/wob.sock"), { repeating = true, locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2*100}' > $XDG_RUNTIME_DIR/wob.sock"), { repeating = true, locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && echo 0 > $XDG_RUNTIME_DIR/wob.sock"))

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true})
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true})
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true})
