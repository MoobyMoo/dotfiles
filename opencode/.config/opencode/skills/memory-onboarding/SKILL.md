---
name: memory-onboarding
description: Build a durable personal profile through a structured onboarding interview
compatibility: opencode
metadata:
  domain: personal-ai
  stage: foundation
---
## Purpose

Use this skill to learn the user well enough to personalize future planning, communication, and automation.

## Outputs

- A compact onboarding summary
- Proposed profile memory entries
- Open questions that still need user confirmation

## Interview areas

- Identity basics: timezone, working hours, primary devices, major life roles
- Communication: concise vs detailed, tone, follow-up style, preferred channels
- Scheduling: sleep window, ideal focus hours, meeting preferences, buffer preferences
- Planning style: daily vs weekly planning, deadline habits, procrastination triggers, review cadence
- Personal operations: errands, bills, travel, health routines, recurring obligations
- Tool stack: Gmail, Google Calendar, Google Drive, Obsidian, task manager, notes flow
- Hard constraints: privacy rules, non-negotiables, topics that always require approval

## Method

1. Ask focused questions in batches.
2. Distinguish stable preferences from temporary context.
3. Convert answers into proposed memory entries using the memory schema.
4. Mark each item as `approve`, `revise`, or `skip`.
5. Keep unresolved uncertainty in an open-questions list instead of forcing a memory.

## Memory quality bar

- Keep only facts that would improve future decisions.
- Prefer explicit user statements over inference.
- Store examples as evidence, not as the memory itself.

## Suggested structure

```yaml
profile:
  - statement: Prefers concise answers with clear next steps.
    evidence: User said they want implementation while learning.
    confidence: high
    approval: pending
```
