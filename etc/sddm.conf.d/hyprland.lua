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

hl.config({
    -- TECLADO E MOUSE
    input = {
        kb_layout = "br",
        follow_mouse = 1,
        sensitivity = 0,
    },

    -- DESATIVA WALLPAPERS PADRÃO e CONFIGURAÇÕES DIVERSAS
    misc = {
        force_default_wallpaper = 0,
        disable_splash_rendering = true,
        disable_hyprland_logo = true,
        vrr = 1, -- necessário para o g-sync
    },

    -- -- CONFIGURAÇÕES DE JANELAS
    -- decoration = {
    --     active_opacity = 0.9,
    --     inactive_opacity = 0.8,
    --     blur = {
    --         enabled = true,
    --         size = 8,
    --         passes = 2,
    --     },
    -- },

    animations = {
        enabled = false,
    },
})

-- REGRAS DE MONITORES / WORKSPACES ESPECÍFICOS
hl.monitor({ output = "DP-1", mode = "preferred", position = "auto", scale = "auto" })
hl.monitor({ output = "DP-2", mode = "preferred", position = "auto", scale = "auto" })

hl.on("hyprland.start", function ()
    hl.exec_cmd("sddm-greeter-qt6")
end)
