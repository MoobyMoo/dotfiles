#!/bin/bash

# Dynamic yazi theme generator based on omarchy theme colors

THEME_DIR="$HOME/.config/omarchy/current/theme"
COLORS_FILE="$THEME_DIR/colors.toml"

if [ ! -f "$COLORS_FILE" ]; then
  COLORS_FILE="$HOME/.local/share/omarchy/themes/catppuccin/colors.toml"
fi

# Parse colors
parse_color() {
  local key=$1
  grep "^$key = " "$COLORS_FILE" | sed 's/.*= "\(.*\)".*/\1/'
}

# Get all colors
ACCENT=$(parse_color "accent")
FOREGROUND=$(parse_color "foreground")
BACKGROUND=$(parse_color "background")
COLOR0=$(parse_color "color0")
COLOR1=$(parse_color "color1")
COLOR2=$(parse_color "color2")
COLOR3=$(parse_color "color3")
COLOR4=$(parse_color "color4")
COLOR5=$(parse_color "color5")
COLOR6=$(parse_color "color6")
COLOR7=$(parse_color "color7")

# Use accent for highlights, darker colors for main areas
HIGHLIGHT=$ACCENT
ACTIVE_BG=$ACCENT
INACTIVE_BG=$COLOR0
TEXT_ON_ACTIVE=$BACKGROUND

# Generate yazi theme.toml in the themes directory
mkdir -p "$HOME/.config/yazi/themes"
cat > "$HOME/.config/yazi/themes/theme.toml" << 'EOF'
[app]
overall = { bg = "reset" }

[mgr]
cwd = { fg = "COLOR6" }

find_keyword  = { fg = "COLOR3", italic = true }
find_position = { fg = "COLOR5", bg = "reset", italic = true }

marker_copied   = { fg = "COLOR2", bg = "COLOR2" }
marker_cut      = { fg = "COLOR1", bg = "COLOR1" }
marker_marked   = { fg = "COLOR6", bg = "COLOR6" }
marker_selected = { fg = "COLOR4", bg = "COLOR4" }

count_copied   = { fg = "BACKGROUND", bg = "COLOR2" }
count_cut      = { fg = "BACKGROUND", bg = "COLOR1" }
count_selected = { fg = "BACKGROUND", bg = "COLOR4" }

border_symbol = "│"
border_style  = { fg = "COLOR7" }

syntect_theme = "~/.config/yazi/theme.tmTheme"

[tabs]
active   = { fg = "BACKGROUND", bg = "FOREGROUND", bold = true }
inactive = { fg = "FOREGROUND", bg = "COLOR0" }

[mode]
normal_main = { fg = "BACKGROUND", bg = "COLOR4", bold = true }
normal_alt  = { fg = "COLOR4", bg = "INACTIVE_BG" }

select_main = { fg = "BACKGROUND", bg = "COLOR2", bold = true }
select_alt  = { fg = "COLOR2", bg = "INACTIVE_BG" }

unset_main  = { fg = "BACKGROUND", bg = "COLOR1", bold = true }
unset_alt   = { fg = "COLOR1", bg = "INACTIVE_BG" }

[indicator]
parent  = { fg = "BACKGROUND", bg = "FOREGROUND" }
current = { fg = "BACKGROUND", bg = "COLOR4" }
preview = { fg = "BACKGROUND", bg = "FOREGROUND" }

[status]
sep_left  = { open = "", close = "" }
sep_right = { open = "", close = "" }

progress_label  = { fg = "FOREGROUND", bold = true }
progress_normal = { fg = "COLOR2", bg = "COLOR0" }
progress_error  = { fg = "COLOR3", bg = "COLOR1" }

mode_normal = { fg = "BACKGROUND", bg = "COLOR4", bold = true }
mode_select = { fg = "BACKGROUND", bg = "COLOR2", bold = true }
mode_unset  = { fg = "BACKGROUND", bg = "COLOR1", bold = true }

permissions_t = { fg = "COLOR4" }
permissions_r = { fg = "COLOR1" }
permissions_w = { fg = "COLOR3" }
permissions_x = { fg = "COLOR2" }
permissions_s = { fg = "COLOR5" }

[file]
fg       = "FOREGROUND"

orphan   = { fg = "COLOR1" }
link     = { fg = "COLOR5" }
external = { fg = "COLOR5" }
EOF

# Replace color placeholders with actual hex values
sed -i "s/COLOR0/$COLOR0/g; s/COLOR1/$COLOR1/g; s/COLOR2/$COLOR2/g; s/COLOR3/$COLOR3/g; s/COLOR4/$COLOR4/g; s/COLOR5/$COLOR5/g; s/COLOR6/$COLOR6/g; s/COLOR7/$COLOR7/g; s/FOREGROUND/$FOREGROUND/g; s/BACKGROUND/$BACKGROUND/g; s/INACTIVE_BG/$INACTIVE_BG/g" "$HOME/.config/yazi/themes/theme.toml"

echo "Yazi theme updated"
