---
description: Monitor the school account for important academic email and calendar signals
agent: personal-admin
---

Use the `student-operating-system` skill.

Goal:
- check the `school` Google account first
- inspect near-term calendar events and recent academic Gmail messages
- identify only high-signal academic items worth proactive notification
- stay read-only

Scope:
- school Google Calendar: today through the next 3 days
- school Gmail: recent unread or recent high-signal messages related to assignments, homework, exams, quizzes, deadlines, E3, TA notices, or course announcements

Output format:
- if nothing important is found, return exactly: `NO_IMPORTANT_UPDATES`
- otherwise return a concise digest with these sections:
  - `## School Alerts`
  - `## Calendar`
  - `## Email`
  - `## Recommended Action`

Rules:
- prefer the `school` account first
- use `personal` only if explicitly needed as fallback
- include message IDs or dates only when useful
- do not send email or modify calendar
- do not include low-value campus spam unless it clearly affects the user

Extra request from user:
$ARGUMENTS
