---
description: Sync classroom and timeblock data from E3 course introductions
agent: personal-admin
---

Use the browser MCP and the student operating system.

Goal:
- use E3 course introduction pages as the primary classroom/timeblock source
- search the user's active E3 courses
- extract classroom, weekday, and timeblock information when clearly visible in the introduction block
- write the results into the introductions/schedule sections of the relevant course pages

Secondary source details:
- if E3 is missing or ambiguous, use `https://timetable.nycu.edu.tw/` only as a fallback
- timetable search endpoint observed: `POST https://timetable.nycu.edu.tw/?r=main/get_cos_list`

Rules:
- only write classroom/timeblock data when the course match is high-confidence
- if multiple course matches exist, keep ambiguity visible instead of guessing
- prefer E3 course introductions over timetable matches when both exist
- map timeblocks like `12` into explicit times, for example `12 = 08:00-09:50`
- update these files intentionally:
  - `/home/moo/Documents/OpenCode-Vault/02_Courses/*.md`

Extra request from user:
$ARGUMENTS
