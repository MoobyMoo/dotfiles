# Google MCP Setup

This file turns your student workflow into a real Google-connected system.

## What is configured now

- `google_workspace` MCP scaffold in `opencode.json`
- `google_tasks` MCP scaffold in `opencode.json`
- both start disabled so OpenCode does not fail before credentials exist
- `google_workspace` is configured in read-only mode first for safer onboarding

## Why this setup

- `google-workspace-mcp` gives the best single on-ramp for Gmail, Calendar, Drive, Docs, and more
- `@overlay-one/google-tasks-mcp-server` gives dedicated Google Tasks access
- Google Keep does not yet have a strong mainstream MCP package, so treat it as the capture inbox for now and promote important items into Tasks or Obsidian

## Files involved

- `~/.config/opencode/opencode.json`
- `~/.config/opencode/commands/student-brief.md`
- `~/.config/opencode/commands/deadline-radar.md`

## Setup order

1. Create Google Cloud OAuth credentials for `google-workspace-mcp`
2. Add your account with `npx google-workspace-mcp accounts add personal`
3. Enable `google_workspace` in `~/.config/opencode/opencode.json`
4. Create Google Tasks OAuth credentials
5. Configure `google_tasks` environment variables and enable it
6. Run `/student-brief`

## Google Workspace MCP setup

Recommended package:
- `google-workspace-mcp`

Recommended first mode:
- read-only

Expected credential path:
- `~/.google-mcp/credentials.json`

Helpful commands:

```bash
npx google-workspace-mcp setup
npx google-workspace-mcp accounts add personal
npx google-workspace-mcp accounts list
npx google-workspace-mcp status
```

To add additional Google accounts later:

```bash
npx google-workspace-mcp accounts add school
npx google-workspace-mcp accounts list
```

Current connected account layout:
- `personal`
- `school`

After account auth succeeds, update `~/.config/opencode/opencode.json`:

```json
"google_workspace": {
  "type": "local",
  "command": ["npx", "-y", "google-workspace-mcp", "serve", "--read-only"],
  "enabled": true,
  "timeout": 15000
}
```

Later, when you trust the workflow more, remove `--read-only`.

## Google Tasks MCP setup

Recommended package:
- `mcp-googletasks-vrob`

This setup now uses a wrapper script at `~/.config/opencode/bin/google-tasks-mcp`.

Why:
- it reuses the existing Google OAuth desktop client stored in `~/.google-mcp/credentials.json`
- it avoids duplicating your client ID and client secret in `opencode.json`

Before it can work, update the same Google Cloud project you already created:

1. Enable the `Google Tasks API`
2. In Google Auth Platform `Data access`, add this scope:

```bash
https://www.googleapis.com/auth/tasks
```

Then OpenCode can launch the Tasks server with:

```json
"google_tasks": {
  "type": "local",
  "command": ["/home/moo/.config/opencode/bin/google-tasks-mcp"],
  "enabled": true,
  "timeout": 15000
}
```

Authentication path:

1. Enable `google_tasks` in `~/.config/opencode/opencode.json`
2. Start an OpenCode session with MCP enabled
3. Use the Tasks server authentication flow once
4. Complete browser auth
5. The Tasks server will persist its credentials locally for future runs

## Keep strategy for now

- Use Google Keep as capture, not as the durable system of record
- During daily review, promote any action items into Google Tasks
- Promote any knowledge worth keeping into Obsidian
- Until a strong Keep MCP is chosen, the agent should treat Keep as an input the user may summarize or manually sync

## Commands you can use after setup

- `/student-brief`
- `/deadline-radar`

Examples:

```text
/student-brief focus on school only today
/deadline-radar include career projects too
```

## Recommended next build step

- connect Google Workspace first
- verify `/student-brief` works with calendar and Gmail
- connect Google Tasks second
- add Obsidian vault path third
