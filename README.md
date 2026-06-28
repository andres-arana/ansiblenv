# ansiblenv

Installer for my personal development environment. An Ansible playbook that
provisions tooling, dotfiles, and shell configuration on a fresh Ubuntu machine
so it matches my usual setup.

## Usage

```bash
gh repo clone andres-arana/ansiblenv
cd ansiblenv
bin/install
```

`bin/install` installs Ansible (via `apt`) and then runs the `environment.yaml`
playbook against `localhost`. It applies whichever roles are enabled in
`environment.yaml` — all of them by default. Any extra arguments are forwarded
to `ansible-playbook`, e.g.:

```bash
bin/install --tags git            # run only tagged tasks
bin/install --check               # dry run
```

## Customizing what gets installed

`environment.yaml` is the source of truth for what runs. Comment out (or remove)
roles you don't want, or add ones you do:

```yaml
---
- hosts: localhost
  connection: local
  roles:
    - autojump
    - fzf
    - bash
    # - docker     # disabled: skip docker on this machine
    - git
    ...
```

## Roles

| Role | What it installs / configures |
|------|-------------------------------|
| **bash** | `starship` prompt, `~/.bashrc` and `~/.bash_profile`, and a `~/.bash.d/` directory that the other roles drop shell snippets into. |
| **software** | General CLI utilities: `curl`, `tree`, `htop`, `bat`, `eza`, plus a broad set of archive managers (`zip`, `unzip`, `p7zip`, `rar`, `unrar`, `arj`, etc.). |
| **git** | `git`, `tig`, and the GitHub CLI (`gh`); installs `~/.gitconfig` and `~/.gitignore`. |
| **vim** | `vim-gtk3` with build tooling (`cmake`, `build-essential`, `universal-ctags`, `silversearcher-ag`, `ripgrep`), vim-plug, CoC settings, UltiSnips snippets, and global `eslint`/`typescript`/python lint deps. |
| **nvim** | Latest Neovim (AppImage) into `~/.local/bin`, plus `ripgrep`, `tree-sitter-cli`, `build-essential`, and the Neovim config under `~/.config/nvim/`. |
| **tmux** | `tmux`, `xclip` for clipboard integration, `~/.tmux.conf`, and TPM (tmux plugin manager). |
| **alacritty** | Alacritty terminal emulator, plus its config and Gruvbox dark/light themes under `~/.config/alacritty/`. |
| **fzf** | `fzf` fuzzy finder with `bat` previews, plus shell init and fzf-git keybindings. |
| **autojump** | `autojump` directory jumping with its shell initializer. |
| **docker** | Docker CE from Docker's apt repo: engine, CLI, `containerd`, and the Compose plugin. |
| **gcloud** | Google Cloud SDK and `kubectl` from Google's apt repo, with `kubectl` bash completion. |
| **nodejs** | Node.js 22.x from the NodeSource apt repo. |
| **claude** | Claude Code (Anthropic CLI) via the native installer into `~/.local/bin`, plus the shared `~/.config/claude/` directory and the global `CLAUDE.md`. |

## Notes

- Targets Ubuntu/Debian — roles use `apt` and `deb822_repository`.
- Idempotent: re-running `bin/install` is safe and brings the machine back to
  the desired state.
- Most package tasks use `become` (sudo), so you'll be prompted for your
  password.
