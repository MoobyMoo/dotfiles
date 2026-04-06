# NYCU Portal Automation

This is the path to fully automate school deadline retrieval.

## Why a browser MCP is needed

The NYCU portal is login-gated and may involve redirects and email verification.
That makes plain HTTP fetching too weak.

So the correct approach is:

- persistent browser profile
- browser MCP automation
- Google Gmail MCP available for optional verification-code retrieval

## Local setup added

- Browser MCP launcher: `~/.config/opencode/bin/browser-mcp`
- MCP entry in `~/.config/opencode/opencode.json`
- Command: `/sync-nycu-portal`

## How it should work

1. Open the persistent browser profile
2. Log into the NYCU portal once manually if needed
3. Reuse that session on future automation runs
4. Navigate to the E3 portal pages that list assignments and deadlines
5. Extract official dates and write them into `DEADLINE_MAP.md`
6. Sync `COURSE_RADAR.md`, `TODAY.md`, and course pages from the deadline map

## Security model

- Do not store the NYCU password in memory or notes
- Prefer a persistent browser session over storing credentials
- If email verification is needed, only read the code via Gmail MCP with your approval

## Practical note

The first run usually needs one manual login.
After that, the browser profile should let future runs reuse the session and become close to fully automatic.
