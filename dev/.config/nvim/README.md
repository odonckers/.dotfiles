# nvim

My Neovim config. Built on Neovim's native `vim.pack` plugin manager (0.12+) rather than
lazy.nvim or packer, with a lockfile at `nvim-pack-lock.json`.

## Structure

- `init.lua` - entrypoint: core options, leader key, the full `vim.pack.add({...})` plugin
  spec, colorscheme, and setup for a few "core" packages (mini.icons, which-key, treesitter
  parser installs).
- `plugin/*.lua` - auto-loaded, one file per concern (`lsp.lua`, `fzf.lua`, `git.lua`,
  `dap.lua`, `format.lua`, `test.lua`, `oil.lua`, `file-tree.lua`, `splits.lua`,
  `quick-fix.lua`, `terminal.lua`, `editing.lua`, `buffers.lua`, `relative-numbers.lua`).
- `after/ftplugin/*.lua` - per-filetype overrides (css, html, js/ts(x), lua, python, rust,
  markdown, kotlin, swift, c, cs, gitcommit, and more).
- `after/lsp/*.lua` - native `vim.lsp.config` server configs (`eslint.lua`, `lua_ls.lua`).
- `after/queries/toml/injections.scm` - custom Tree-sitter injection query for mise.toml-style
  files.
- `stylua.toml` / `.luarc.json` - formatter/lint config for this config itself.

Leader is `,`, local leader is `\`.

## Notable plugins

- **LSP** - native `vim.lsp` + `nvim-lspconfig`, `rustaceanvim` (Rust), `roslyn.nvim`
  (deeply tuned C#/.NET setup), `lazydev.nvim`, `nvim-lsp-file-operations`.
- **Completion** - `nvim-cmp` (LSP/buffer/path/cmdline/spell sources) + `friendly-snippets`.
- **Fuzzy finder** - `fzf-lua` (files, live grep, oldfiles, buffers, marks, resume).
- **Colorscheme** - selected from the shared `~/.config/dotfiles/config.json` appearance;
  the Modus theme follows the terminal's `background`.
- **Git** - `gitsigns.nvim`, extensively mapped (hunk stage/reset/preview, blame, diff,
  quickfix).
- **File explorer** - `neo-tree.nvim` and `oil.nvim` for buffer-style directory editing.
- **Testing/Debugging** - `neotest` (`neotest-jest`, `neotest-vstest`), `nvim-dap` +
  `nvim-dap-view` / `persistent-breakpoints.nvim` / `nvim-dap-virtual-text`.
- **Other** - `which-key.nvim` (helix preset), `mini.surround`, `mini.icons`,
  `smart-splits.nvim`, `nvim-pqf`, `conform.nvim`, `arborist.nvim`.

## Standout customizations

- No statusline plugin - relies on Neovim's native global statusline (`laststatus = 3`).
- Deep `roslyn.nvim` tuning (inlay hints, code lens, background analysis scope) for .NET work.
- Custom Tree-sitter predicate (`is-mise?`) to special-case `*mise*.toml` files.
- Toggleable diagnostics UX via `SetVirtualLines`/`SetNoVirtualLines` and
  `SetInlayHints`/`SetNoInlayHints` user commands.
- Insert-mode relative-number toggling driven by a `vim.g.relativenumber` flag.
- Startup tuning: `vim.loader.enable()`, large-file syntax limits, deferred clipboard setup.
