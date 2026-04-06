---
description: Create missing school calendar events from confirmed deadline map entries
agent: personal-admin
---

Use the `student-operating-system` skill.

Goal:
- read `/home/moo/Documents/OpenCode-Vault/01_Dashboard/DEADLINE_MAP.md`
- find rows marked `Confirmed`
- create matching events in the `school` primary calendar when they do not already exist

Rules:
- only use rows with explicit due date and `Confirmed` status
- do not create duplicates if a matching event already exists
- treat the `school` primary calendar as the destination for academic deadline events
- keep event titles concise: `<Course> - <Item>`
- default duration: 30 minutes unless the entry clearly represents an exam block or includes a time range
- include source and next action in the description
- do not modify or delete existing events in this workflow; only create missing ones

Extra request from user:
$ARGUMENTS
