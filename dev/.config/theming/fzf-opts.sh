#!/usr/bin/env sh
# Builds an FZF_DEFAULT_OPTS value from the currently-loaded THEME_* vars
# (call theming_colors first -- see colors.sh). Shared so the value is
# identical whether it's exported by an interactive shell's precmd hook
# (.zshrc) or pushed into tmux's environment table (apply-tmux.sh) for
# fzf invocations tmux spawns directly (tmux-fzf's C-s, the popup-based
# `prefix + e` repo picker) that never source .zshrc.
theming_fzf_opts() {
  echo "
    --color=fg:$THEME_TX_2,bg:$THEME_BG,hl:$THEME_TX
    --color=fg+:$THEME_TX_2,bg+:$THEME_BG_2,hl+:$THEME_TX
    --color=border:$THEME_RE_2,header:$THEME_TX,gutter:$THEME_BG
    --color=spinner:$THEME_CY_2,info:$THEME_CY_2,separator:$THEME_BG_2
    --color=pointer:$THEME_YE_2,marker:$THEME_RE_2,prompt:$THEME_YE_2"
}
