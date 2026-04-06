# Personal Memory Schema

Use this schema for durable memory in propose-then-approve mode.

## Core record

```yaml
id: memory-uuid
type: profile | operational | episode
statement: short durable fact
evidence: short source summary
source: conversation | email | calendar | doc | manual
confidence: low | medium | high
approval_state: pending | approved | rejected | superseded
sensitivity: low | medium | high
created_at: ISO-8601 timestamp
last_verified_at: ISO-8601 timestamp or null
expires_at: ISO-8601 timestamp or null
supersedes: null or memory id
```

## Type guidance

- `profile`: stable personal preferences, communication style, routines, constraints
- `operational`: current commitments, active projects, near-term priorities, recurring obligations
- `episode`: compact event summaries that may help later retrieval

## Approval guidance

- `pending`: default for anything new
- `approved`: user confirmed or policy auto-approved low-risk fact
- `rejected`: not useful, incorrect, or too sensitive
- `superseded`: replaced by a newer approved fact

## Good examples

- Prefers concise implementation-focused answers.
- Uses Gmail, Google Calendar, and Google Drive as primary personal admin tools.
- Wants read-and-draft-only automation at the start.

## Bad examples

- Raw email transcript
- Guessed emotional state
- Secret, token, password, or OTP
- Sensitive personal judgment presented as fact
