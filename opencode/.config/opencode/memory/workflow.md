# Memory Workflow

This system is meant to compound over time.

## Rules

1. New sessions should read `current-profile.md` first.
2. If more detail is needed, consult `approved.yaml`.
3. New durable facts should be proposed before they are saved.
4. Proposed facts go into `pending.yaml` until approved or rejected.
5. Approved facts should be merged into `approved.yaml` and, if important, reflected in `current-profile.md`.
6. Rejections, corrections, and superseded items should be recorded in `review-log.md`.

## What counts as durable memory

- communication style
- planning preferences
- recurring failure modes
- stable routines or constraints
- tool preferences
- major priorities
- long-lived operating rules

## What does not belong here

- secrets
- raw private messages
- one-off moods
- guessed personality judgments
- temporary tasks that belong in a task system instead
