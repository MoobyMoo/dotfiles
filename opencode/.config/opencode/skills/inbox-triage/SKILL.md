---
name: inbox-triage
description: Triage email into action, waiting, archive, and draft categories
compatibility: opencode
metadata:
  domain: personal-admin
  tools: gmail
---
## Purpose

Turn a noisy inbox into a small set of actions.

## Categories

- `urgent-action`
- `needs-draft`
- `waiting-on-them`
- `reference-only`
- `archive`

## Workflow

1. Group related email threads.
2. Identify commitments, deadlines, and asks.
3. Surface replies worth drafting.
4. Extract tasks or calendar implications.
5. Propose durable memory only when a pattern is likely to repeat.

## Output format

- Priority threads
- Suggested drafts
- New tasks or follow-ups
- Memory candidates

## Guardrails

- Prefer concise reply drafts.
- Separate facts from assumptions.
- Never send by default.
