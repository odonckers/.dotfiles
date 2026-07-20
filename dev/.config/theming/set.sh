#!/usr/bin/env sh
# Switch the active theme: writes the name into `active-theme` and, if a
# tmux server is running, applies it immediately (both dark and light don't
# need a restart -- fzf/delta already recompute from active-theme on every
# use). Usage: theming/set.sh <name>   e.g. theming/set.sh github
set -eu

DIR="$(cd "$(dirname "$0")" && pwd)"

NAME="${1:?usage: set.sh <theme-name>}"
if [ ! -f "$DIR/themes/$NAME.sh" ]; then
  echo "theming/set.sh: unknown theme '$NAME' (no themes/$NAME.sh)" >&2
  exit 1
fi

echo "$NAME" > "$DIR/active-theme"
"$DIR/apply-tmux.sh"
echo "theme set to $NAME"
