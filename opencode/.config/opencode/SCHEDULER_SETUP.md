# Scheduler Setup

This is the first proactive automation loop.

## What it does

- runs the student briefing automatically every morning
- writes the latest output to `~/.config/opencode/logs/student-brief-latest.md`
- sends the result to Telegram if Telegram secrets are available in Fish config

## Files

- `~/.config/opencode/bin/run-student-brief`
- `~/.config/opencode/bin/run-deadline-radar`
- `~/.config/opencode/bin/run-automation-healthcheck`
- `~/.config/systemd/user/opencode-student-brief.service`
- `~/.config/systemd/user/opencode-student-brief.timer`
- `~/.config/systemd/user/opencode-deadline-radar.service`
- `~/.config/systemd/user/opencode-deadline-radar.timer`
- `~/.config/systemd/user/opencode-automation-healthcheck.service`

## Default schedule

- `07:30` every day in local system time
- `15:00` every day in local system time for deadline radar

## Useful commands

```bash
systemctl --user daemon-reload
systemctl --user enable --now opencode-student-brief.timer
systemctl --user enable --now opencode-deadline-radar.timer
systemctl --user status opencode-student-brief.timer
systemctl --user status opencode-deadline-radar.timer
systemctl --user start opencode-student-brief.service
systemctl --user start opencode-automation-healthcheck.service
journalctl --user -u opencode-deadline-radar.service -n 50 --no-pager
journalctl --user -u opencode-student-brief.service -n 50 --no-pager
```

## How it fits the mission

- memory gives the briefing continuity across sessions
- MCPs give it real Google context
- Telegram makes it proactive instead of purely manual
- systemd makes it run without you opening OpenCode

## Reboot behavior

- The current timers are enabled and survive normal reboots/login.
- They need your user systemd session to come up after boot.
- `Persistent=true` means missed runs can fire after you log back in.
- `loginctl enable-linger moo` would make this even stronger, but it did not take effect from this session and may need you to run it locally with the right privileges.
- The startup healthcheck service can be run after login to confirm the automation stack is healthy and send that status to Telegram.

## Next scheduler additions

- weekly review timer
- optional evening shutdown review
