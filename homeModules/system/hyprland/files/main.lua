local active_colour = { colors = { "rgba(4CAF50F2)", "rgba(00FF99EE)" }, angle = 45 }
local inactive_colour = "rgba(595959aa)"

hl.config({
    ecosystem = {
        no_update_news = true,
        no_donation_nag = true,
    },

    general = {
        border_size = 2,
        gaps_in = 5,
        gaps_out = 10,
        layout = "dwindle",

        col = {
            active_border = active_colour,
            inactive_border = inactive_colour
        }
    },

    decoration = {
        rounding = 10,
        blur = {
            enabled = true,
        },
        shadow = {
            enabled = true,
        },
    },

    dwindle = {
        preserve_split = true,
    },

    input = {
        kb_layout = "gb",
        sensitivity = 0,
        follow_mouse = 2,
        float_switch_override_focus = 0
    },

    misc = {
        -- Wallpaper
        force_default_wallpaper = -1,
        disable_splash_rendering = true,

        -- Ensure we can wakeup
        mouse_move_enables_dpms = true,
        key_press_enables_dpms = true,

        -- Stop applications showing "Not Responding" dialogue
        enable_anr_dialog = false,

        -- Disable middle click paste
        middle_click_paste = false,
    },

    cursor = {
        no_hardware_cursors = true,
    },

    animations = {
        enabled = true,
    },
})
