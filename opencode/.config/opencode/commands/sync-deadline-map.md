---
description: Sync the verified deadline map into dashboards and course pages
agent: personal-admin
---

Use the `student-operating-system` skill.

Goal:
- treat `/home/moo/Documents/OpenCode-Vault/01_Dashboard/DEADLINE_MAP.md` as the primary academic deadline truth layer
- update `COURSE_RADAR.md`, `TODAY.md`, `WEEK.md`, and relevant course pages from it
- keep unknown dates visible instead of replacing them with guesses

Rules:
- only promote dates marked by official or user-confirmed sources
- if the deadline map is empty, surface that as the main system risk
- prefer the deadline map over Gmail/Drive hints when they conflict
- if Calendar/Tasks are missing confirmed items that exist in the deadline map, flag the gap clearly

Files to update intentionally:
- `/home/moo/Documents/OpenCode-Vault/01_Dashboard/DEADLINE_MAP.md`
- `/home/moo/Documents/OpenCode-Vault/01_Dashboard/COURSE_RADAR.md`
- `/home/moo/Documents/OpenCode-Vault/01_Dashboard/TODAY.md`
- `/home/moo/Documents/OpenCode-Vault/01_Dashboard/WEEK.md`
- relevant files in `/home/moo/Documents/OpenCode-Vault/02_Courses/`

Extra request from user:
$ARGUMENTS
