---
name: memory-candidate-review
description: Review, prune, and format proposed memory before it becomes durable
compatibility: opencode
metadata:
  domain: personal-ai
  safety: approval-gated
---
## Purpose

Use this skill whenever a conversation or workflow suggests something worth remembering.

## Candidate classes

- `profile`: stable preferences, communication style, routines, constraints
- `operational`: current projects, commitments, obligations, active priorities
- `episode`: short summaries of notable events that may matter later

## Review checklist

1. Is the fact explicit rather than inferred?
2. Will it improve future decisions or automation?
3. Is it stable enough to outlive the current session?
4. Is it sensitive enough to require explicit approval?
5. Does it contradict an existing memory?

## Output format

```yaml
candidates:
  - type: profile
    statement: Prefers propose-then-approve memory.
    evidence: User selected this memory mode during setup.
    confidence: high
    approval: required
    expires_at: null
```

## Never store by default

- Secrets and credentials
- Raw private message bodies unless heavily summarized
- Health, legal, financial, or relationship judgments inferred by the agent
- One-off moods that are unlikely to remain useful
