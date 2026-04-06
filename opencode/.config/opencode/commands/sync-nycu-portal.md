---
description: Sync NYCU portal deadlines through browser automation
agent: personal-admin
---

Use the browser MCP together with the student operating system.

Goal:
- open the NYCU portal and E3 pages in the persistent browser profile
- reuse an existing logged-in session if present
- if not logged in, prompt the user only for the minimum interactive step needed
- extract official upcoming assignments, quizzes, exams, and due dates
- write confirmed items into `/home/moo/Documents/OpenCode-Vault/01_Dashboard/DEADLINE_MAP.md`
- then sync the dashboards and course pages from the updated deadline map

Rules:
- prefer official portal/LMS data over Gmail or Drive hints
- do not store the password in memory or files
- if login requires MFA/email verification, use the Gmail MCP only to read the verification code after the user explicitly approves that behavior
- if email verification is needed and the code lands in Google, check the `school` account first
- keep the browser profile persistent so future runs reuse the session
- treat extracted dates as official only when clearly visible in the portal
- do not click submission, unsubmission, delete, or confirm-action controls in E3
- remain strictly read-only with coursework state unless the user explicitly asks for a write action

Minimum outputs:
- what was extracted
- what courses/pages were visited
- what items were written into `DEADLINE_MAP.md`
- what still needs manual confirmation

Extra request from user:
$ARGUMENTS
