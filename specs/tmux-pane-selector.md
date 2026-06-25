# Spec: tmux fzf pane selector with bell status

## Overview
A single additive feature for the tmux config: an fzf-driven popup that lists
every pane across the whole tmux server, previews pane contents, surfaces
windows with a pending bell, and jumps to the selected pane. This supersedes
the earlier multi-feature plan — the agent-state hooks (per-pane `@agent_state`)
and the agent tree are **out of scope** for now; the existing bell notification
on Claude "done"/"blocked" is considered sufficient.

## Conventions & install contract
- Helper script ships as a non-executable-or-executable `.sh` in
  `roles/tmux/files/` (matching the repo's existing `fzf-git.sh` /
  `gh-completion.bash` convention).
- **Proposed** install location: `~/.tmux/scripts/` (mode `0755`), deployed via a
  new `ansible.builtin.copy` task in `roles/tmux/tasks/main.yaml`.
- `tmux.conf` invokes the script through `display-popup -E`.
- Dependencies (all already present): `fzf` (own ansible role), `tmux` 3.2+
  (`display-popup`), standard `tmux` format strings.
- **Proposed** keybinding: `prefix f` (free today; used keys are
  `r q | _ - c T t d s Escape`).

## Behavior
- `prefix f` opens a `display-popup -E` running fzf.
- fzf is fed **all panes across the whole server** (every session, every
  window), one pane per row.
- Each row is labeled with its location and context, e.g.
  `session:window.pane  window_name  pane_current_command` (exact column layout
  is an implementation detail).
- Rows whose **window** has a pending bell are marked with a bell glyph (🔔).
  Bell is a window property in tmux, so the marker reflects window-level state
  and is shown on every pane row belonging to a belled window (see Edge cases).
- A live preview pane shows `capture-pane -ep` of the currently highlighted
  pane.
- Selecting a row jumps focus to that pane: switch client to its session,
  select its window, then select the pane (as needed). The popup closes.
- Focusing a belled window via the jump auto-clears that window's bell
  (existing tmux behavior with `monitor-bell`; nothing extra required).

## Inputs
- Pane list sourced from `tmux list-panes -a -F '<format>'`, where the format
  includes at minimum: `session_name`, `window_index`, `window_name`,
  `pane_index`, `pane_current_command`, `pane_title`, and `window_bell_flag`
  (window-scoped, referenced from the pane format).
- Preview command: `tmux capture-pane -ep -t <target>` for the highlighted row's
  pane target.

## Outputs
- Side effect: focus moves to the selected session/window/pane.
- No stdout contract beyond what fzf needs internally; the popup closes on
  selection or cancel.

## Bell status semantics
- The selector reports the **window** bell flag (`window_bell_flag`); tmux has
  no native per-pane bell flag.
- True per-pane bell would require a hook-written pane marker — explicitly **not**
  built here (that was the dropped Feature 3).
- Belled rows SHOULD be visually distinct (glyph) and MAY be ordered/grouped
  ahead of non-belled rows so pending notifications are easy to find.

## Edge cases
- **Single pane on the whole server:** list shows one row; selecting it is a
  no-op jump. Must not error.
- **Multi-pane belled window:** every pane row in that window shows the bell
  glyph; the selector cannot single out which pane rang. Accepted limitation.
- **No bells pending:** no rows carry the glyph; selector behaves as a plain
  pane switcher.
- **Pane dies between list build and jump:** jump fails gracefully (no crash,
  popup still closes).
- **Very long pane list:** fzf scrolls normally; no truncation of the list.
- **Invoked from within the popup's own transient pane:** the popup is ephemeral
  (`display-popup`), so it should not appear as a selectable row.

## Error handling
- Empty selection / `Esc` / Ctrl-C in fzf → no jump, popup closes cleanly.
- `tmux capture-pane` failing for a target (e.g. pane just died) → preview shows
  empty/nothing; no crash.
- Jump to a now-dead target → fail silently; do not leave the client in a broken
  state.

## Constraints / Non-goals
- **No agent-state tracking** (`@agent_state`), no Claude Code hook changes, no
  agent status icons. The existing bell-on-done/blocked is the only agent signal.
- **No agent tree / persistent sidebar.**
- **Jump only** — no create/kill/rename/move of sessions/windows/panes from the
  selector.
- **No remote/SSH/mobile/web** surface (herdr's domain).
- Does not replace or alter existing binds or the `tmux-fingers` plugin.

## Open items to confirm at implementation
- Keybinding `prefix f` (proposed).
- Script install path `~/.tmux/scripts/` (proposed).
- Exact row column layout and bell-glyph choice.
