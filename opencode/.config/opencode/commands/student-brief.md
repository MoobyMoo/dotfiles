---
description: Run a student-focused daily briefing
agent: personal-admin
---

Use the `student-operating-system` skill and produce a student daily briefing.

Priorities for this run:
- use Google Calendar, Google Tasks, Gmail, Drive, and Keep MCP tools if they are configured
- prefer the `school` Google Workspace account first for academic signals and use `personal` only as a fallback
- if Google tools are not connected yet, fall back to local memory and ask the user for the missing high-value inputs inside the briefing itself
- use the `student-planner` subagent if deadline analysis or recovery planning is needed

Output sections:
- Right Now
- Priority Stack
- Deadline Radar
- Deep Work Block
- Keep -> Tasks -> Obsidian

Extra request from user:
$ARGUMENTS
