---
description: Automatically update low-risk durable memory and queue sensitive items for review
agent: personal-admin
---

Use the `memory-candidate-review` skill and the `memory-curator` subagent.

Goal:
- inspect durable profile memory, recent automation outputs, and durable vault pages
- identify low-risk, high-confidence memory updates
- auto-apply those updates to approved memory
- update the compact current profile when core behavior changes
- send uncertain, contradictory, or sensitive items to `pending.yaml`

Files to read and update:
- `~/.config/opencode/memory/current-profile.md`
- `~/.config/opencode/memory/approved.yaml`
- `~/.config/opencode/memory/pending.yaml`
- `~/.config/opencode/memory/review-log.md`
- `~/.config/opencode/logs/student-brief-latest.md`
- `~/.config/opencode/logs/deadline-radar-latest.md`
- `/home/moo/Documents/OpenCode-Vault/01_Dashboard/TODAY.md`
- `/home/moo/Documents/OpenCode-Vault/01_Dashboard/COURSE_RADAR.md`

Auto-apply policy:
- auto-apply only low-risk, high-confidence, durable facts
- queue medium/high sensitivity items or contradictions in `pending.yaml`
- do not store raw private messages, secrets, or one-off moods
- prefer updating existing memory over adding duplicates
- do not stop at analysis; complete the file edits in this run

Review log policy:
- append a short note to `review-log.md` for each automatic sync run
- mention applied updates, queued updates, and skipped updates

Extra request from user:
$ARGUMENTS
