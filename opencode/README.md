# OpenCode Dotfiles Package

This package tracks the portable parts of the personal AI system.

## Included

- `~/.config/opencode/`
- `~/.config/systemd/user/opencode-*.service`
- `~/.config/systemd/user/opencode-*.timer`

## Not included

These stay machine-local and should not be committed:

- `~/.google-mcp/` (Google auth/session state)
- `~/.config/mcp-googletasks-vrob/` (Google Tasks auth state)
- `~/.config/opencode/browser-profile/` (browser session state for NYCU/E3)
- `~/.config/opencode/logs/` (runtime logs)
- `~/.config/fish/conf.d/opencode.local.fish` (Telegram token/chat id and any future secrets)

## Portability

- The OpenCode config itself is portable across machines.
- The `systemd --user` units are Linux-specific.
- On macOS or Windows, keep the OpenCode config and vault, but replace the scheduler with that platform's equivalent.

## Restore on a new Linux machine

```bash
cd ~/dotfiles
stow opencode
stow opencode-vault
systemctl --user daemon-reload
systemctl --user enable --now opencode-student-brief.timer
systemctl --user enable --now opencode-deadline-radar.timer
systemctl --user enable --now opencode-memory-sync.timer
systemctl --user enable --now opencode-school-signal-monitor.timer
```

Then restore local state separately if desired:

- `~/.google-mcp/`
- `~/.config/mcp-googletasks-vrob/`
- `~/.config/opencode/browser-profile/`
- `~/.config/fish/conf.d/opencode.local.fish`
