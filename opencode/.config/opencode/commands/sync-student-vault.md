---
description: Automatically refresh the student vault from live tools and durable memory
agent: personal-admin
---

Use the `student-operating-system` skill.

Goal:
- refresh the durable student operating pages automatically
- use live Google Workspace and Google Tasks data when available
- keep the vault aligned with the current state of school, tasks, and deadlines

Files to update intentionally:
- `/home/moo/Documents/OpenCode-Vault/01_Dashboard/TODAY.md`
- `/home/moo/Documents/OpenCode-Vault/01_Dashboard/WEEK.md`
- `/home/moo/Documents/OpenCode-Vault/01_Dashboard/COURSE_RADAR.md`
- relevant files in `/home/moo/Documents/OpenCode-Vault/02_Courses/`

Rules:
- auto-write low-risk operational updates directly
- do not overwrite unknowns with guesses
- if a deadline or next action is high-confidence, write it
- if there is conflicting information, keep the ambiguity visible instead of pretending certainty
- prefer the `school` Google account first for academic Gmail, Calendar, Drive, and Docs context
- treat Google Calendar and Google Tasks as execution truth when they are explicit
- treat Drive/Gmail as evidence, not perfect truth
- keep the pages concise and scan-friendly
- do not stop at analysis; you must complete the file edits in this run

What to infer automatically:
- active courses
- next visible deadlines
- current next actions
- risk level
- today and this week's focus

Extra request from user:
$ARGUMENTS
