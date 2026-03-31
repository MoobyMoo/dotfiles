#!/bin/bash

# Generate starship.toml with colors from current omarchy theme
# This ensures starship always matches the current theme

THEME_DIR="$HOME/.config/omarchy/current/theme"
COLORS_FILE="$THEME_DIR/colors.toml"
OUTPUT_FILE="$HOME/.config/starship.toml"

# Read colors from theme file
read_color() {
  grep "^$1 =" "$COLORS_FILE" | cut -d'"' -f2
}

# Get colors
ACCENT=$(read_color "accent")
FOREGROUND=$(read_color "foreground")
COLOR1=$(read_color "color1")  # red
COLOR4=$(read_color "color4")  # blue/accent
COLOR5=$(read_color "color5")  # magenta
COLOR6=$(read_color "color6")  # cyan

# Use accent color for main theme, or fall back to color4
MAIN_COLOR="${ACCENT:-$COLOR4}"

# Generate starship config
cat > "$OUTPUT_FILE" << EOF
add_newline = true
command_timeout = 200
format = "[\$directory\$git_branch\$git_status](\$style)\$character"

[character]
error_symbol = "[✗](bold $COLOR1)"
success_symbol = "[❯](bold $MAIN_COLOR)"

[directory]
truncation_length = 2
truncation_symbol = "…/"
repo_root_style = "bold $MAIN_COLOR"
repo_root_format = "[\$repo_root](\$repo_root_style)[\$path](\$style)[\$read_only](\$read_only_style) "

[git_branch]
format = "[\$branch](\$style) "
style = "italic $COLOR5"

[git_status]
format     = '[\$all_status](\$style)'
style      = "$COLOR6"
ahead      = "⇡\${count} "
diverged   = "⇕⇡\${ahead_count}⇣\${behind_count} "
behind     = "⇣\${count} "
conflicted = " "
up_to_date = " "
untracked  = "? "
modified   = " "
stashed    = ""
staged     = ""
renamed    = ""
deleted    = ""
EOF

echo "Updated starship.toml with colors from current theme"
