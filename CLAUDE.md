# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A personal Ansible playbook that provisions an Ubuntu/Debian workstation (tooling, dotfiles, shell config) against `localhost`. There is no build or test suite; "running" the project means applying the playbook to the current machine.

## Commands

```bash
bin/install                  # apt-installs ansible, then runs environment.yaml on localhost
bin/install --check          # dry run (extra args are forwarded to ansible-playbook)
bin/install --tags <tag>     # run only tagged tasks
bin/save                     # copy live dotfiles from $HOME back into roles/*/files/
```

`ansible.cfg` points Ansible at `inventory` (localhost, local connection, Python pinned to `/usr/bin/python3`), so Ansible commands must run from the repo root. Most tasks use `become`, so a real run prompts for sudo and changes the host machine — don't run `bin/install` without being asked; prefer `--check` to validate.

## Architecture

- `environment.yaml` is the source of truth for which roles run; disabling a role means commenting it out there.
- Each role under `roles/<name>/` has `tasks/main.yaml`, optional `files/` (the dotfiles it deploys), and optional `meta/main.yaml` declaring role dependencies (e.g. most roles depend on `bash`; `nvim` depends on `nodejs` and `fzf`; `alacritty` depends on `tmux`).
- **`~/.bash.d/` plugin convention:** the `bash` role creates `~/.bash.d/` (and `~/.bash.d/bin/`, on PATH), and `bashrc` sources every `~/.bash.d/*.bash`. Other roles add shell integration by copying a `*.bash` snippet there (fzf init, fzf-git, gh completion, cl completion, …) rather than editing `bashrc`.
- **Cross-role optional features** are gated with `when: "'<role>' in ansible_role_names"` (e.g. fzf-git keybindings only if `git` is enabled; the gruvbox `tigrc` only if `alacritty` is enabled). Use this pattern instead of hard dependencies when a feature merely integrates with another role.
- **Two-way dotfile sync:** files in `roles/*/files/` are copies of the live configs. `bin/save` pulls them from `$HOME` back into the repo, so when adding a new deployed dotfile, also add the reverse `cp` line to `bin/save` if it's something edited in place.
- User-level binaries go to `~/.local/bin` (nvim AppImage, Claude Code, the `cl` launcher).
- `roles/claude/files/CLAUDE.md` is the user's *global* Claude config deployed to `~/.config/claude/CLAUDE.md` — not instructions for this repo. The `cl` script launches Claude with a profile under `~/.config/claude/<profile>/`, whose CLAUDE.md imports the shared one via `@../CLAUDE.md`.
- `specs/` holds design specs for larger features (written before implementation).

## Conventions

- Tasks follow ansible-lint style: fully-qualified module names (`ansible.builtin.*`), quoted octal modes (`mode: '0644'`), every task named.
- Third-party apt repos use `ansible.builtin.deb822_repository` with `signed_by` pointing at the vendor key URL.
- When adding or removing a role, update the roles table in `README.md`.
