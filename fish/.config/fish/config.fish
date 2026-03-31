set -g fish_greeting ""

# fcitx5 configuration
set -gx GTK_IM_MODULE fcitx5
set -gx QT_IM_MODULE fcitx
set -gx SDL_IM_MODULE fcitx5
set -gx XMODIFIERS @im=fcitx

# Environment variables from Bash config
set -gx SUDO_EDITOR "$EDITOR"
set -gx BAT_THEME ansi
set -gx OMARCHY_PATH $HOME/.local/share/omarchy
set -gx PATH $OMARCHY_PATH/bin:$PATH:$HOME/.local/bin

if status is-interactive
  # Commands to run in interactive sessions can go here
  starship init fish | source
end

# File system aliases
if command -v eza &>/dev/null
  alias ls='eza -lh --group-directories-first --icons=auto'
  alias lsa='ls -a'
  alias lt='eza --tree --level=2 --long --icons --git'
  alias lta='lt -a'
end

alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
alias eff='$EDITOR "$(ff)"'

if command -v zoxide &>/dev/null
  alias cd=zd
  function zd
    if test (count $argv) -eq 0
      builtin cd ~ || return
    else if test -d $argv[1]
      builtin cd $argv[1] || return
    else
      if not z $argv
        echo "Error: Directory not found"
        return 1
      end
      printf "\U000F17A9 "
      pwd
    end
  end
end

function open
  xdg-open $argv >/dev/null 2>&1 &
end

# Directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Tools
alias c='opencode'
alias cx='printf "\033[2J\033[3J\033[H" && claude --allow-dangerously-skip-permissions'
alias d='docker'
alias r='rails'
alias t='tmux attach || tmux new -s Work'
function n
  if test (count $argv) -eq 0
    command nvim .
  else
    command nvim $argv
  end
end

# Git
alias g='git'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gcad='git commit -a --amend'

# Yazi shell integration: y to cd on quit
function y
  set tmp (mktemp -t "yazi-cwd.XXXXXX")
  yazi $argv --cwd-file="$tmp"
  if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
    builtin cd -- "$cwd"
  end
  rm -f -- "$tmp"
end

# Initialize zoxide (smarter cd)
zoxide init fish | source
