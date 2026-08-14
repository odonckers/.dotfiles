#!/usr/bin/env zsh

# Split out from .zshrc so the tmux popup (prefix e, tmux.conf) can source
# just this file instead of the whole interactive shell (Oh My Zsh, plugins,
# compinit) -- that alone adds ~800ms to popup open time.
dev() {
  local template="${1:-dev}"

  # -I (ignore .gitignore) because some repos -- e.g. mani-managed meta-repos
  # -- gitignore their own nested child repos (often via a blanket "**/"
  # pattern), which would also hide the meta-repo's own .git from a
  # gitignore-respecting scan. To keep that from being slow, we --exclude
  # the well-known heavy dependency dirs by name instead of relying on
  # .gitignore, and --prune so fd stops descending the instant it matches a
  # .git dir instead of walking its internal object store.
  local repo
  repo=$(fd -HI '^\.git$' ~/dev --prune \
      --exclude node_modules --exclude .venv --exclude venv \
      --exclude target --exclude dist --exclude build --exclude vendor \
      --exclude Pods --exclude .terraform --exclude .next --exclude .nuxt \
      --exclude bin --exclude obj --exclude .cache --exclude DerivedData \
    | sed -E 's:/\.git/?$::' \
    | sort -u \
    | fzf --prompt="Select repo > " --height=100% --border --reverse)

  [[ -z "$repo" ]] && return 1

  local name
  name=$(basename "$repo")
  if [[ "$repo" == "$HOME/dev/worktrees/"* ]]; then
    name="$(basename "$(dirname "$repo")")/$name"
  fi

  DEV_REPO_ROOT="$repo" DEV_REPO_NAME="$name" tmuxinator start "$template"
}
