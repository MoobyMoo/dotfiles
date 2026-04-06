---
description: Review pending memory and apply approved updates to the durable profile
agent: personal-admin
---

Review `~/.config/opencode/memory/pending.yaml` and `~/.config/opencode/memory/approved.yaml`.

Goal:
- show pending memory updates
- identify which should be approved, rejected, or revised
- if the user confirms approval, apply the update to `approved.yaml`
- refresh `current-profile.md` if the approved change affects core behavior
- record the decision in `review-log.md`

Rules:
- never approve sensitive or uncertain items silently
- prefer updating existing memory over creating duplicates

Extra request from user:
$ARGUMENTS
