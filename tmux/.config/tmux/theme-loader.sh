#!/bin/bash

# This script dynamically generates tmux color commands based on the current omarchy theme
# It's sourced by tmux to ensure colors update with theme changes

THEME_DIR="$HOME/.config/omarchy/current/theme"
COLORS_FILE="$THEME_DIR/colors.toml"

if [ ! -f "$COLORS_FILE" ]; then
  # Fallback to default theme
  COLORS_FILE="$HOME/.local/share/omarchy/themes/catppuccin/colors.toml"
fi

# Parse the colors.toml file
parse_color() {
  local key=$1
  grep "^$key = " "$COLORS_FILE" | sed 's/.*= "\(.*\)".*/\1/'
}

# Extract colors from TOML
ACCENT=$(parse_color "accent")
FOREGROUND=$(parse_color "foreground")
BACKGROUND=$(parse_color "background")

# Output tmux commands to be sourced
cat << EOF
# Auto-generated tmux theme configuration
# Based on current omarchy theme: $(cat $HOME/.config/omarchy/current/theme.name 2>/dev/null || echo "catppuccin")

# Color palette
set -g @accent "$ACCENT"
set -g @foreground "$FOREGROUND"
set -g @background "$BACKGROUND"

# Status bar
set -g status-style "bg=default,fg=$FOREGROUND"
set -g status-left "#[fg=$BACKGROUND,bg=$ACCENT,bold] #S #[bg=default,fg=$FOREGROUND] "
set -g status-right "#[fg=$ACCENT]#{?client_prefix,PREFIX ,}#{?window_zoomed_flag,ZOOM ,}#[fg=brightblack]#h "
set -g window-status-format "#[fg=brightblack] #I:#W "
set -g window-status-current-format "#[fg=$ACCENT,bold] #I:#W "

# Borders and indicators
set -g pane-border-style "fg=brightblack"
set -g pane-active-border-style "fg=$ACCENT"
set -g message-style "bg=default,fg=$ACCENT"
set -g message-command-style "bg=default,fg=$ACCENT"
set -g mode-style "bg=$ACCENT,fg=$BACKGROUND"
setw -g clock-mode-colour "$ACCENT"
EOF
