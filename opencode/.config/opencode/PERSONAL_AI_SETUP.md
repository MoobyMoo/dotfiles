# Personal AI Setup

This folder turns OpenCode into a starter personal AI operating layer.

## What is included

- `agents/personal-admin.md`: main coordinator for your life-admin workflows
- `agents/memory-curator.md`: subagent for high-quality memory extraction
- `skills/memory-onboarding/`: onboarding interview and profile seeding
- `skills/memory-candidate-review/`: memory pruning and approval formatting
- `skills/daily-briefing/`: daily summary workflow
- `skills/inbox-triage/`: inbox reduction workflow
- `skills/student-operating-system/`: student-focused workflow for deadlines, study planning, and recovery mode
- `memory/schema.md`: durable memory schema
- `memory/onboarding-template.md`: questions and known setup defaults
- `commands/student-brief.md`: runs a student daily briefing
- `commands/deadline-radar.md`: runs deadline risk analysis
- `GOOGLE_MCP_SETUP.md`: step-by-step Google integration guide

## Recommended first MCPs

1. Google Calendar
2. Google Tasks
3. Google Keep
4. Gmail
5. Google Drive

Start in read-and-draft mode until the workflows feel reliable.

## Notes model

For your setup, the best model is hybrid:
- `Google Keep` for fast temporary capture
- `Obsidian` for durable notes, class knowledge, projects, and dashboarding

This fits your student workflow better than `Keep only` or `Obsidian only`.

Keep reduces friction. Obsidian prevents long-term knowledge sprawl.

## Suggested implementation order

1. Run the `memory-onboarding` skill and fill `memory/onboarding-template.md`.
2. Add Calendar, Tasks, and Keep integrations first.
3. Add Gmail and Drive after the student workflow loop is working.
4. Test `student-operating-system` for daily planning and deadline radar.
5. Test `daily-briefing` and `inbox-triage` without sending email.
6. Start reviewing memory candidates after each useful session.

## How subagents fit

- `personal-admin` coordinates the task.
- `memory-curator` extracts durable memory candidates.
- `student-planner` handles deadlines, deep-work planning, and recovery mode.
- Future subagents can specialize further in inbox, calendar, travel, or weekly review.

## Next additions

- Google MCP setup for Calendar, Tasks, Keep, Gmail, and Drive
- Obsidian local-vault workflow
- follow-up manager skill
- weekly review skill
- approval log and memory registry

## Commands

- `/student-brief`
- `/deadline-radar`
