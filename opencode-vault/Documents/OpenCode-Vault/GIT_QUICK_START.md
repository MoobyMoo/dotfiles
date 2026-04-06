# Git Quick Start Guide for OpenCode-Vault

## Your Repository is Ready!

Your `OpenCode-Vault` project now has git initialized with:
- Initial commit: `da82037` (all your files backed up)
- `.gitignore` configured (excludes Obsidian, temp files, etc.)
- Identity set: OpenCode User <user@opencode.local>

---

## Daily Workflow (Step by Step)

### 1. Check What Changed

```bash
cd /home/moo/Documents/OpenCode-Vault
git status
```

Output shows:
- Modified files (red)
- Untracked files (if new)
- Clean working tree (all committed)

### 2. Make Changes to Files

Edit your markdown, add notes, whatever you want:
```bash
vim ACTIVE_PROJECTS.md
# or edit in Neovim, etc.
```

### 3. Check What You Changed

```bash
git diff
```

This shows:
- Lines you added (green, with +)
- Lines you removed (red, with -)
- Exact changes before committing

### 4. Stage Your Changes

```bash
# Stage one file
git add ACTIVE_PROJECTS.md

# Stage all changes
git add .

# Stage specific changes from a file (advanced)
git add -p ACTIVE_PROJECTS.md
```

### 5. Commit (Save Your Work)

```bash
git commit -m "docs: update active projects list"
```

Message format: `<type>: <description>`

Types:
- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation change
- `refactor:` - Code restructuring (no behavior change)
- `style:` - Formatting, whitespace
- `perf:` - Performance improvement
- `test:` - Adding/updating tests

### 6. View Your History

```bash
# One-line commits
git log --oneline

# Detailed commits
git log

# See changes in last commit
git show HEAD

# See changes in specific commit
git show da82037
```

---

## Using Branches for Features

### Creating a Feature Branch

```bash
# Create and switch to new branch
git checkout -b feature/new-project-plan

# Or: git switch -c feature/new-project-plan
```

This creates a parallel line of work without affecting master.

### Working on Your Branch

```bash
# Make changes
vim ACTIVE_PROJECTS.md

# Stage and commit normally
git add .
git commit -m "feat: add new project structure"

# See your commits on this branch
git log --oneline
```

### Switching Back to Master

```bash
git checkout master
# or: git switch master
```

Your changes stay on the feature branch, master is unaffected.

### Merging Your Branch Back

```bash
# Make sure you're on master
git checkout master

# Merge feature branch
git merge feature/new-project-plan

# Delete the feature branch when done
git branch -d feature/new-project-plan
```

---

## Viewing Your Commits

```bash
# See all commits with details
git log

# See compact format
git log --oneline

# See last 5 commits
git log -5

# See commits with file changes
git log --stat

# See full diffs
git log -p

# See blame (who changed each line)
git blame ACTIVE_PROJECTS.md
```

---

## Undoing Things

### View what was committed
```bash
git show HEAD
```

### Undo last commit (keep changes)
```bash
git reset --soft HEAD~1
```
Changes go back to staging area, you can modify and recommit.

### Undo last commit (discard changes)
```bash
git reset --hard HEAD~1
```
⚠️ WARNING: This deletes the changes, use carefully!

### Undo changes to a file (before committing)
```bash
git restore ACTIVE_PROJECTS.md
# or: git checkout -- ACTIVE_PROJECTS.md
```

### Undo changes to a file (after committing)
```bash
git restore --source=HEAD~1 ACTIVE_PROJECTS.md
```

---

## Using Lazygit in Neovim

In Neovim, press `<space>gg` to open lazygit.

### Committing with Lazygit

1. Press `Tab` to go to "Files" panel
2. Press `Space` on each file to stage it (or `A` to stage all)
3. Press `Tab` again to go back to "Status" area
4. Press `c` to commit
5. Type your commit message
6. Press Enter twice (confirm)

### Creating Branches with Lazygit

1. Press `Tab` until you see "Branches" panel
2. Press `n` to create new branch
3. Type branch name: `feature/new-thing`
4. Press Enter
5. You're now on that branch

### Switching Branches with Lazygit

1. In "Branches" panel
2. Highlight the branch you want
3. Press `Space` to switch

### Viewing Commit History with Lazygit

1. In "Commits" panel (press Tab to navigate)
2. Use arrow keys to select a commit
3. Press Enter to see full details in the "Diff" panel

---

## Quick Reference

| Task | Command | Lazygit |
|------|---------|---------|
| Check status | `git status` | Default view |
| View changes | `git diff` | View in Diff panel |
| Stage all | `git add .` | Press `A` in Files |
| Commit | `git commit -m "msg"` | Press `c` in Status |
| View history | `git log --oneline` | View Commits panel |
| Create branch | `git checkout -b name` | Press `n` in Branches |
| Switch branch | `git checkout name` | Press Space in Branches |
| Merge branch | `git merge name` | Highlight commit, press `r` |
| Delete branch | `git branch -d name` | Highlight branch, press `d` |

---

## Example: Your First Feature with Git

```bash
# 1. Create feature branch
git checkout -b feature/update-projects

# 2. Make changes
vim ACTIVE_PROJECTS.md

# 3. Check what changed
git diff

# 4. Stage changes
git add ACTIVE_PROJECTS.md

# 5. Commit
git commit -m "feat: reorganize project categories"

# 6. Switch back to master
git checkout master

# 7. See master doesn't have changes yet
cat ACTIVE_PROJECTS.md

# 8. Merge feature back in
git merge feature/update-projects

# 9. Now master has the changes
cat ACTIVE_PROJECTS.md

# 10. Cleanup
git branch -d feature/update-projects

# 11. View history
git log --oneline
```

---

## Tips

- **Commit often** - Small commits are easier to understand and debug
- **Write clear messages** - Your future self will thank you
- **Use branches** - Keep experimental work separate from master
- **Use .gitignore** - Don't commit temporary files, node_modules, etc.
- **Pull before push** - Always sync with others before pushing (if using GitHub)
- **Review before committing** - Use `git diff` to check what's really changing

---

## Next Steps

1. Practice creating branches and merging locally
2. When ready, learn to push to GitHub (if you want backup)
3. For team work, learn pull requests and code review
4. Read more: https://git-scm.com/book/en/v2

Happy version controlling!
