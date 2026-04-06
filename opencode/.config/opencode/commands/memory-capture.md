---
description: Extract proposed durable memory from the current conversation or task
agent: personal-admin
---

Use the `memory-candidate-review` skill and the `memory-curator` subagent.

Goal:
- identify durable memory candidates from the current context
- compare them against `~/.config/opencode/memory/approved.yaml`
- avoid duplicates and low-value clutter
- present only the candidates worth saving

Rules:
- do not silently save approved memory
- write new proposals into `~/.config/opencode/memory/pending.yaml` only if the user asks to store them
- call out contradictions, corrections, or stale items explicitly

Extra request from user:
$ARGUMENTS
