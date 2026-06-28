# Tab-complete profile names for `cl` (the executable in ~/.bash.d/bin). Profiles
# are directories under ~/.config/claude, excluding the `shared` common layer.
_cl_complete() {
  if [[ "$COMP_CWORD" -ne 1 ]]; then
    return
  fi
  local base="$HOME/.config/claude"
  local profiles
  profiles="$(find "$base" -mindepth 1 -maxdepth 1 -type d ! -name shared \
    -printf '%f\n' 2>/dev/null)"
  mapfile -t COMPREPLY < <(compgen -W "$profiles" -- "${COMP_WORDS[COMP_CWORD]}")
}
complete -F _cl_complete cl
