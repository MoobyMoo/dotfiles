# Linux Skills

## Purpose

This note is a long-term reference for Linux concepts that keep showing up during development, shell usage, terminal workflows, and config debugging.

The focus is not just commands, but the reason behind them.

---

## Core Linux Mental Model

Linux systems are built from small tools that do one thing well.

Why this matters:

- the fastest way to learn Linux is to stop expecting one giant GUI-style control panel for everything
- file paths, processes, permissions, environment variables, and shell behavior all connect together

---

## Paths and Directories

### `.` and `..`

- `.` means current directory
- `..` means parent directory

Why this matters:

- commands like `nvim .` or `cd ..` depend on these path shortcuts

### Absolute vs relative paths

- absolute path starts from root, like `/home/moo/Documents`
- relative path starts from current directory, like `Documents` or `../School`

Why this matters:

- many tools behave differently depending on where they are launched from

---

## Config vs Data

Typical pattern on Linux:

- `~/.config/...` = editable user config
- `~/.local/share/...` = installed tools, runtime data, caches, stateful app data

Why this matters:

- understanding where a file lives often explains whether it should be edited directly

Example:

- Neovim config in `~/.config/nvim`
- plugin installs in `~/.local/share/nvim/lazy`

---

## Shell Skills

### Alias vs function

Alias:

- simple text shortcut

Function:

- real shell logic

Why this matters:

- if behavior depends on arguments, a function is often the right tool

Example:

- `n` as a function can do one thing with no args and another with file args

### Current shell matters

Bash config and Fish config are different.

Why this matters:

- a command working in Fish does not mean the same alias/function exists in Bash

---

## Environment Variables

Environment variables store runtime settings like:

- `PATH`
- `EDITOR`
- `HOME`

Why this matters:

- they influence which executables can be found and how tools behave

### `PATH`

`PATH` is the list of directories the shell searches for commands.

Why this matters:

- if a tool is installed but not on `PATH`, it behaves as if missing

---

## Processes and Background Tools

Programs can launch other programs in the background.

Why this matters:

- LSP servers are usually local background processes
- terminal integrations often spawn subprocesses

Example:

- Neovim launches `clangd`, `pyright`, `verible-verilog-ls`, etc. as local processes

---

## Symlinks

A symlink is a special file that points to another path.

Why this matters:

- it lets one file path mirror another without duplication

Example:

- `~/.config/nvim/lua/plugins/theme.lua` can be a symlink to Omarchy's generated theme file

Useful commands:

```bash
ls -l path
readlink -f path
ln -sf target linkname
```

---

## Permissions

Linux permissions control who can:

- read
- write
- execute

Why this matters:

- executable scripts need execute permission
- config and runtime bugs can sometimes be permission issues, not logic issues

---

## Git and Project Roots

Many tools look for `.git` to detect project root.

Why this matters:

- LSP behavior, search tools, file explorers, and root-aware plugins often depend on project root detection

Problem pattern:

- school/homework directories without `.git` can confuse tools that expect repo roots

Fix pattern:

- explicitly set root detection or create fallback logic

---

## Build Metadata Matters

Some languages need extra metadata files.

Examples:

- C/C++ -> `compile_commands.json`
- Python -> `pyproject.toml`, `pyrightconfig.json`

Why this matters:

- language tools are often not broken; they are missing context

---

## File Explorers and Directory Ownership

When an app opens a directory, one tool needs to "own" that behavior.

Why this matters:

- if multiple explorers try to hijack the same directory-opening flow, the result feels broken or duplicated

Lesson:

- when choosing Yazi as the directory explorer inside Neovim, competing explorers like Neo-tree or Snacks explorer should be disabled for that use case

---

## Good Linux Debugging Pattern

1. Check the path
2. Check the executable
3. Check the current shell
4. Check the environment variables
5. Check whether another tool is racing/conflicting
6. Prefer the smallest fix that explains the behavior clearly

Why this works:

- most Linux problems are not random; they are path, process, config, or ownership problems

---

## High-Value Reminders

- config and installed runtime are usually different locations
- symlinks are often cleaner than duplicating generated files
- shell functions are better than aliases when logic is needed
- one explorer should own directory opening
- one source of truth is better than multiple overlapping integrations
- most weird tool behavior becomes clearer once path/root/process ownership is understood
