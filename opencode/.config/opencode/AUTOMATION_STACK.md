# Automation Stack

This is the proactive layer that will sit on top of memory, MCPs, and skills.

## Mission fit

The goal is not just to answer questions.
The goal is to build a personal assistant that compounds over time and acts proactively.

## Layers

1. Memory
- know the user across sessions

2. Tools
- Gmail, Calendar, Drive, Tasks, Keep, Obsidian

3. Workflows
- student briefing, deadline radar, inbox triage, weekly review

4. Scheduling
- automatic morning, evening, and weekly runs

5. Notifications
- Telegram is the preferred first channel

## Immediate automation plan

1. Connect Google Tasks
2. Add Obsidian path
3. Add Telegram bot and notification secrets
4. Add a daily scheduled run for `/student-brief`
5. Add a scheduled run for `/deadline-radar`
6. Add a weekly-review workflow

## Safety model

- summaries can run automatically
- drafts can run automatically
- email sending stays approval-gated
- memory updates stay propose-then-approve

## Current notification primitive

- `~/.config/opencode/bin/send-telegram` sends a message using `TELEGRAM_BOT_TOKEN` and `TELEGRAM_CHAT_ID`
- `~/.config/opencode/bin/telegram-status` validates whether the Telegram wiring is ready

## Current scheduler primitive

- `~/.config/opencode/bin/run-student-brief` runs the `/student-brief` workflow non-interactively
- `~/.config/systemd/user/opencode-student-brief.service` executes the run
- `~/.config/systemd/user/opencode-student-brief.timer` schedules it every morning
- `~/.config/opencode/bin/run-deadline-radar` runs the `/deadline-radar` workflow non-interactively
- `~/.config/systemd/user/opencode-deadline-radar.service` executes the radar run
- `~/.config/systemd/user/opencode-deadline-radar.timer` schedules it every afternoon
- `~/.config/opencode/bin/run-sync-student-vault` refreshes the durable vault automatically
- `~/.config/opencode/bin/run-sync-deadlines-to-calendar` writes confirmed academic deadlines into the school calendar
- `~/.config/opencode/bin/run-auto-memory-sync` refreshes low-risk durable memory automatically
- `~/.config/systemd/user/opencode-memory-sync.timer` schedules nightly memory compounding
- `~/.config/opencode/bin/run-school-signal-monitor` checks school Gmail/calendar for important academic signals
- `~/.config/systemd/user/opencode-school-signal-monitor.timer` schedules school alerts every 2 hours
