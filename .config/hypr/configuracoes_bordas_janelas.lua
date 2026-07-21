local colors = dofile(os.getenv("HOME") .. "/.cache/wal/colors-hyprland.lua")

hl.config({
    general = {
        border_size = 2,
        col = {
            active_border = colors.color4 .. "ee",
            inactive_border = colors.color0 .. "aa"
        }
    }
})
