-- Hyprland loads this file when it is started without a config, and it prefers
-- it over hyprland.conf. HyDE loads it too, last, as the override layer below.
-- The block keeps the two apart: hyde.lua sets `hyde` on its first line, so it
-- runs only when this file is the entry point and HyDE has not been loaded.
-- Removing it leaves a session with a cursor and nothing else.
if not hyde then
    local share = os.getenv("XDG_DATA_HOME") or (os.getenv("HOME") .. "/.local/share")
    local entry = share .. "/hypr/hyde.lua"
    local handle = io.open(entry, "r")
    if not handle then
        error("HyDE is not installed at " .. entry .. ". Run install.sh -r, or point Hyprland at your own config.")
    end
    handle:close()
    dofile(entry)
end

-- Your Hyprland configuration. HyDE never overwrites this file.
--
-- It loads after HyDE's own binds, so settings here take precedence. Replacing
-- a bind needs more than that: see below. HyDE's defaults live in
-- ~/.local/share/hypr/lua/ and are overwritten on every update, so edits there
-- do not survive.
--
-- Adding a keybind:
--
--     hl.bind("SUPER + SPACE", hl.dsp.exec_cmd(hyde.sh.gamelauncher()), {
--         description = "[Utilities] game launcher",
--     })
--
-- Replacing one of HyDE's: bind the same combination again and yours takes
-- over, but copy its flags across as well. A bind counts as the same one only
-- when its flags match, and `description` is not a flag — miss one and both
-- binds stay live on that combination. Copy the whole options table from
-- ~/.local/share/hypr/lua/key_binds.lua and change only what you need:
--
--     hl.bind("F9", hl.dsp.exec_cmd(hyde.sh.volumecontrol("-o", "m")), {
--         locked = true,
--         description = "[Hardware Controls|Audio] un/mute output",
--     })
--
-- Press SUPER + / to see what is actually loaded, your own binds included.
-- The full reference is KEYBINDINGS.md in the HyDE repository.
--
-- Other Lua files next to this one can be pulled in with require("name").


-- ============================================
-- INPUT/MISC SETTINGS
-- ============================================
hl.config({
    input = {
        kb_layout = "us",
        sensitivity = 0.35,
        accel_profile = "flat",
        touchpad = {
            natural_scroll = true,
            scroll_factor = 0.4,
        },
    }
})

hl.config({
    animations = {
        enabled = false,
    },
})

-- hl.env("XCURSOR_THEME", "Adwaita")
-- hl.env("XCURSOR_SIZE", "24")
-- hl.env("HYPRCURSOR_THEME", "Adwaita")
-- hl.env("HYPRCURSOR_SIZE", "24")


-- ============================================
-- WINDOW DECORATIONS
-- ============================================
hl.config({
    general = {
        gaps_in = 3,
        gaps_out = 6,
        border_size = 2,
        ["col.active_border"] = "rgba(ffffff44)",
        ["col.inactive_border"] = "rgba(ffffff11)",
    },
    decoration = {
        rounding = 12,
        active_opacity = 1,
        inactive_opacity = 0.87,
        fullscreen_opacity = 1,
        blur = {
            enabled = true,
            size = 6,
            passes = 3,
            new_optimizations = true,
            ignore_opacity = true,
        },
        shadow = {
            enabled = false,
        },
        glow = {
            enabled = false,
        },
        screen_shader = "",
    }
})

-- ============================================
-- MONITOR SETTINGS
-- ============================================

local function apply_laptop_scale()
    local laptop = hl.get_monitor("eDP-1")
    local docked = laptop ~= nil and #laptop.mirrors > 0
    hl.monitor({
        output = "eDP-1",
        mode = "preferred",
        position = "auto",
        --all nums truthy in lua
        scale = docked and 1 or 1.33,
    })


end

apply_laptop_scale()
hl.on("monitor.added", apply_laptop_scale)
hl.on("monitor.removed", apply_laptop_scale)

-- ============================================
-- KEYBINDINGS
-- ============================================

hl.bind("SUPER + BACKSPACE", hl.dsp.exec_cmd("~/.local/bin/wlogout-custom"), {
    description = "[System] Logout menu",
})

hl.bind("SUPER + A", hl.dsp.exec_cmd("rofi -show drun"), {
    description = "[Launcher] Rofi app launcher",
})

hl.bind("SUPER + Y", hl.dsp.exec_cmd("~/Documents/SXCTXT/launcher.sh"), {
    description = "[Launcher] Textbook launcher",
})

hl.bind("SUPER + SHIFT + C", hl.dsp.exec_cmd("~/.local/bin/custom-colors"), {
    description = "[Theming] Custom waybar/kitty colours",
})

hl.bind("SUPER + C", hl.dsp.exec_cmd(hyde.sh.waybar("--hide")), {
    description = "[Window Management] Hide waybar",
})


hl.bind("SUPER + M", hl.dsp.exec_cmd('hyprctl setcursor "Adwaita" 20'), {
    description = "[System] Fix mouse",
})

--mirror
hl.monitor({ output = "desc:Samsung Electric Company LF24T450F HCPXB00872", mode = "1920x1080@75", mirror = "eDP-1" })

--stupid way to get rid fo 6-10???!!!

local function noop() end

hl.bind("SUPER + 6", noop, { description = "[Disabled] Workspace 6" })
hl.bind("SUPER + 7", noop, { description = "[Disabled] Workspace 7" })
hl.bind("SUPER + 8", noop, { description = "[Disabled] Workspace 8" })
hl.bind("SUPER + 9", noop, { description = "[Disabled] Workspace 9" })
hl.bind("SUPER + 0", noop, { description = "[Disabled] Workspace 10" })

hl.bind("SUPER + SHIFT + 6", noop, { description = "[Disabled] Move to workspace 6" })
hl.bind("SUPER + SHIFT + 7", noop, { description = "[Disabled] Move to workspace 7" })
hl.bind("SUPER + SHIFT + 8", noop, { description = "[Disabled] Move to workspace 8" })
hl.bind("SUPER + SHIFT + 9", noop, { description = "[Disabled] Move to workspace 9" })
hl.bind("SUPER + SHIFT + 0", noop, { description = "[Disabled] Move to workspace 10" })

-- ============================================
-- STARTUP APPLICATIONS
-- ============================================
-- hl.exec_once = hl.exec_once or {}
-- hl.exec_once["mako"] = true
-- hl.exec_once.cmd = "mako"

hl.on("hyprland.start", function()
    hl.exec_cmd('hyprctl setcursor "Adwaita" 20')
    hl.exec_cmd("mako")
    -- hl.exec_cmd("sleep 5 && pkill hyprsunset ; notify-send 'hyprsunset' 'i died'")
    -- hl.exec_cmd("sleep 2 && systemctl --user start hyprsunset.service")
end)
-- alternative - hyde startup system
-- hl.exec_on("hyprland.start", function()
--     hl.dsp.exec_cmd("mako")
-- end)

-- ============================================
-- HYPRIDLE SETTINGS (Power management)
-- ============================================

-- listener {
--     timeout = 300
--     on-timeout = brightnessctl -s && brightnessctl s 1%
--     on-resume = brightnessctl -r
-- }

-- listener {
--     timeout = 600
--     on-timeout = loginctl lock-session
-- }

-- listener {
--     timeout = 3600
--     on-timeout = hyprctl dispatch dpms off
--     on-resume = hyprctl dispatch dpms on
-- }
