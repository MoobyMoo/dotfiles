# Personal AI Roadmap

This roadmap captures what we are building, why it matters, what is already done, and what remains.

## Goal

Build a personal AI operating system that:

- knows the user across sessions through durable memory
- uses the user's real tools through MCP integrations
- packages repeated workflows as reusable skills and commands
- supports student life, personal admin, and later broader life automation
- can eventually run on a schedule and notify the user proactively

## Target architecture

### 1. Durable memory layer

Purpose:
- carry preferences, routines, constraints, and stable user context across OpenCode sessions

Core pieces:
- `memory/current-profile.md`
- `memory/profile-draft-2026-04-06.md`
- `memory/schema.md`
- `memory/onboarding-template.md`

Behavior we want:
- new sessions rebuild context from memory files
- new durable facts are proposed, not silently stored
- memory gets reviewed and refined over time

### 2. Agent and subagent layer

Purpose:
- route work to the right specialist instead of overloading one agent

Core pieces:
- `agents/personal-admin.md`
- `agents/memory-curator.md`
- `agents/student-planner.md`

Behavior we want:
- `personal-admin` coordinates work
- `memory-curator` extracts durable memory candidates
- `student-planner` handles deadlines, deep work, and recovery mode

### 3. Skill layer

Purpose:
- make repeated workflows reusable and consistent

Core pieces:
- `skills/memory-onboarding/`
- `skills/memory-candidate-review/`
- `skills/daily-briefing/`
- `skills/inbox-triage/`
- `skills/student-operating-system/`

Behavior we want:
- daily briefing
- inbox triage
- student planning and deadline radar
- later weekly review, follow-up management, automation reviews

### 4. Tool/MCP layer

Purpose:
- let the agent act through the user's real systems

Current target stack:
- Google Workspace MCP for Gmail, Calendar, Drive, Docs
- Google Tasks MCP
- Google Keep as capture input for now
- Obsidian as durable notes/knowledge layer

Behavior we want:
- real calendar-aware briefings
- inbox and draft workflows
- task-aware prioritization
- later notes promotion and retrieval

### 5. Automation layer

Purpose:
- move from manual invocation to scheduled, proactive support

Future pieces:
- scheduler (`cron` or `systemd --user`)
- notification channel (Telegram preferred)
- automation scripts or wrapper commands
- approval rules for risky actions

Behavior we want:
- morning briefing sent automatically
- deadline/risk alerts
- weekly review reminders
- optional quick approval workflows through Telegram later

## User model this system is built around

- EE/CS student at NYCU EE
- timezone: Taiwan/Taipei
- values academic performance, career growth, life organization, health and energy
- prefers detailed, structured answers with strong recommendations
- responds well to direct reminders and a firm-coach tone when needed
- works best in long deep-work sessions with structured checklists
- main failure modes are deadline pileups, hard starts, information overload, context switching, fragmentation, overplanning, avoidance, and sleep drift
- wants Google Keep for temporary capture and Obsidian for durable knowledge

## What is already done

### Foundation

- [x] create OpenCode personal AI folder structure
- [x] create main `personal-admin` agent
- [x] create `memory-curator` subagent
- [x] create `student-planner` subagent
- [x] create initial setup docs

### Memory

- [x] define durable memory schema
- [x] run first onboarding pass
- [x] run deeper background onboarding pass
- [x] store compact durable profile in `memory/current-profile.md`
- [x] update agents so fresh sessions consult durable memory files
- [x] set memory policy to propose-then-approve

### Skills and commands

- [x] add `memory-onboarding` skill
- [x] add `memory-candidate-review` skill
- [x] add `daily-briefing` skill
- [x] add `inbox-triage` skill
- [x] add `student-operating-system` skill
- [x] add `/student-brief`
- [x] add `/deadline-radar`
- [x] add `/memory-status`
- [x] add `/google-setup-status`

### Google setup

- [x] scaffold MCP config for Google Workspace
- [x] scaffold MCP config for Google Tasks
- [x] create Google OAuth app and credentials file
- [x] add `personal` Google Workspace account
- [x] connect `google_workspace` MCP in read-only mode

## What is partially done

- [~] daily briefing exists as a workflow, but does not yet have the full Google Tasks + Keep + Obsidian loop
- [~] memory persists across sessions through files, but the update/review loop is still manual/semi-manual
- [~] Google Workspace is connected, but we have not yet validated all real daily workflows end-to-end

## What is not done yet

### Immediate next steps

- [ ] connect `google_tasks` MCP
- [ ] verify a real calendar-aware `/student-brief`
- [ ] verify a real `/deadline-radar`
- [ ] decide whether to add more Google accounts beyond `personal`
- [ ] add Obsidian vault path

### Notes and knowledge layer

- [ ] define the Obsidian vault location
- [ ] decide folder structure for class notes, dashboard, and projects
- [ ] create a promotion workflow from Keep/tasks into Obsidian

### Automation

- [ ] choose Telegram as the first notification channel
- [ ] create Telegram bot/webhook integration
- [ ] create a scheduled morning briefing runner
- [ ] create a scheduled deadline-radar runner
- [ ] create a weekly review runner

### Safety and governance

- [ ] create an approval log
- [ ] define which actions can be automatic, drafted, or approval-gated
- [ ] define memory review cadence
- [ ] add a clear change/update workflow for durable memory

### Workflow expansion

- [ ] add weekly-review skill
- [ ] add follow-up manager skill
- [ ] add automation-audit/check skill
- [ ] add a study dashboard workflow

## Recommended implementation order from here

1. Connect `google_tasks`
2. Validate real Google-backed briefings
3. Add Obsidian path and workflow
4. Add Telegram notifications
5. Add scheduling
6. Add memory update/review loop improvements
7. Add weekly review and follow-up skills

## What success looks like

The finished system should let the user:

- open a fresh OpenCode session and be known from durable memory
- ask for planning help and get context-aware answers grounded in real tools
- receive daily and weekly support without manually rebuilding context every time
- gradually automate more of life admin, student operations, and personal organization
- keep risky actions approval-gated while low-risk summarization runs automatically

## Quick status snapshot

- Memory foundation: ready
- Agent/skill foundation: ready
- Google Workspace MCP: connected
- Google Tasks MCP: not connected
- Obsidian integration: not connected
- Telegram notifications: not connected
- Scheduler: not connected
- Full automation loop: not connected
