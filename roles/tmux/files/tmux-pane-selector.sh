#!/usr/bin/env bash
# fzf pane selector with bell status. Bound to `prefix f`, run inside a
# display-popup. Lists every pane across the whole tmux server, previews the
# highlighted pane's contents, marks panes whose window has a pending bell, and
# jumps to the selected pane.
#
# Bell is a window property in tmux (no native per-pane flag), so the 🔔 marker
# reflects window-level state and shows on every pane row of a belled window.
# Focusing a belled window on jump auto-clears its bell (monitor-bell default).
set -euo pipefail

TAB=$'\t'

# Stable IDs (#{pane_id}=%N, #{window_id}=@N, #{session_id}=$N) are globally
# unique and contain no delimiter chars, so jumping needs no fragile parsing.
# Field 1 is a sort key (0=belled, 1=not) used to float notifications to the
# top; --with-nth=5.. makes fzf both display and search only field 5 onward,
# hiding fields 1-4 from view and from fuzzy matching.
list() {
  tmux list-panes -a -F \
"#{?window_bell_flag,0,1}${TAB}#{pane_id}${TAB}#{window_id}${TAB}#{session_id}${TAB}#{?window_bell_flag,🔔 ,   }#{session_name}:#{window_index}.#{pane_index}  [#{window_name}]  #{pane_current_command}  #{pane_title}"
}

selected="$(
  list | sort -t"$TAB" -k1,1 | fzf \
    --delimiter="$TAB" \
    --with-nth=5.. \
    --prompt='pane> ' \
    --preview 'tmux capture-pane -ep -t {2}' \
    --preview-window='right:60%:wrap'
)" || exit 0

[ -n "$selected" ] || exit 0

pane_id="$(printf '%s' "$selected" | cut -d"$TAB" -f2)"
window_id="$(printf '%s' "$selected" | cut -d"$TAB" -f3)"
session_id="$(printf '%s' "$selected" | cut -d"$TAB" -f4)"

# Best-effort jump; a target may have died between listing and selection.
tmux switch-client -t "$session_id" 2>/dev/null || true
tmux select-window -t "$window_id" 2>/dev/null || true
tmux select-pane -t "$pane_id" 2>/dev/null || true
