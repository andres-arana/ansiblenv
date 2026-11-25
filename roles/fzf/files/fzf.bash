# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"
export BAT_THEME='gruvbox-dark'

# List with fd so .gitignore is respected and dotfiles are included
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'

# Hooks fzf calls for ** completion, so it uses fd too
_fzf_compgen_path() { fd --hidden --follow --exclude .git . "$1"; }
_fzf_compgen_dir() { fd --type d --hidden --follow --exclude .git . "$1"; }

# No --color: fzf follows the terminal palette
export FZF_DEFAULT_OPTS='--height=40% --layout=reverse --border'
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:200 {}' --bind 'ctrl-/:toggle-preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --level=2 --color=always {}'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window up:3:hidden:wrap --bind 'ctrl-/:toggle-preview'"
