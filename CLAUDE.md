# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

This is a personal Neovim configuration based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). It lives at `~/.config/nvim` and is loaded directly by Neovim — there is no build step. It tracks upstream kickstart's default branch (`master`), which uses Neovim's built-in **`vim.pack`** plugin manager (not lazy.nvim).

## Working in this repo

- **Formatting Lua:** run `stylua .` (config in `.stylua.toml`: 2-space indent, 160 col width, single quotes preferred, no call parens, `collapse_simple_statement = "Always"`). All Lua here follows this style.
- **Applying changes:** edits take effect when Neovim is restarted (or the relevant module re-sourced). There are no tests.
- **Managing plugins:** plugins are installed by `vim.pack.add`. Inspect/update via `:lua vim.pack.update(nil, { offline = true })` (pending) and `:lua vim.pack.update()`. `:Mason` manages LSP servers/formatters/linters; `:checkhealth` diagnoses issues. There is **no `lazy-lock.json`** (that was lazy.nvim).
- **Syncing upstream:** `git fetch upstream && git merge upstream/master`. Keep `init.lua` and `lua/kickstart/**` pristine so merges stay conflict-free — see below.

## Architecture

`init.lua` is upstream kickstart's single file, kept **pristine** except two intentional lines (`vim.g.have_nerd_font = true` and an uncommented `require 'custom.plugins'`). All personal config lives in files upstream never touches:

- **`init.lua`** (~1000 lines) — upstream's config, organized into 10 `do … end` `SECTION` blocks. Plugins are installed with `vim.pack.add { gh 'org/repo' }` (the `gh()` helper prefixes the GitHub URL) followed immediately by `require('mod').setup { … }`. Build steps live in a single `PackChanged` autocmd in SECTION 3 (e.g. treesitter `:TSUpdate`, LuaSnip). **Do not edit** beyond the two exceptions.

- **`lua/custom/plugins/*.lua`** — loaded via `require 'custom.plugins'` (SECTION 10). `custom/plugins/init.lua` is an imperative loader that `require`s every sibling `*.lua`. **Each file runs plain code** (`vim.pack.add { 'https://github.com/org/repo' }` then `require('mod').setup{}` + keymaps/autocmds) — it does NOT return a spec table. These files load **last**, after all base sections, so they can override base plugin setups (re-run `.setup{}`) and all base plugins/deps are already available. Personal plugins: `harpoon.lua` (harpoon2), `neogit.lua`, `neo-tree.lua`, `obsidian.lua`, `gruvbox.lua` (inactive), `nordic.lua` (active theme), `render-markdown.lua`, `claude.lua`. Overrides of base plugins: `conform.lua`, `lsp.lua`. To add a plugin, create a new file here following the same pattern.

- **`plugin/*.lua`** — Neovim runtime files sourced automatically at startup (plugin-manager-agnostic). Personal options (`options.lua`) and keymaps (`keymaps.lua`) live here.

- **`lua/kickstart/plugins/*.lua`** — upstream optional modules (debug, lint, autopairs, gitsigns, indent_line, neo-tree). Commented out in `init.lua`; unused (this repo uses `custom.plugins.neo-tree` instead).

## LSP, formatters, and linters

- **Base servers** are declared in the `servers` table in `init.lua` (SECTION 6) and enabled via `vim.lsp.enable`; Mason installs them through `mason-tool-installer`.
- **Personal servers + tools** live in `lua/custom/plugins/lsp.lua`: enabled with the native `vim.lsp.config`/`vim.lsp.enable` API (kotlin_lsp uses a custom `intellij-server` cmd and is excluded from Mason), and installed via `mason-tool-installer` (`ensure_installed` includes angularls, yamlls, lemminx, markdown_oxide, terraformls, helm_ls, jsonls + formatters/linters like xmlformatter, gofumpt, prettier, ktlint). blink.cmp capabilities are applied to all servers via `vim.lsp.config('*', …)`.
- **Formatting** is `conform.nvim`, overridden in `lua/custom/plugins/conform.lua`: `format_on_save` for all filetypes except c/cpp, and `formatters_by_ft` (e.g. `xml → xmlformatter` with custom `prepend_args`, `lua → stylua`). `<leader>f` formats manually.
- **Treesitter** is configured in `init.lua` SECTION 9 on the `main` branch (on-demand parser install + FileType attach); no custom override.

## Notable custom keymaps

Leader is `<space>`. Beyond kickstart defaults:
- `<leader>go` — open the current repo's origin URL in the browser (converts SSH→HTTPS).
- `<leader>gg` — Neogit floating panel; `<leader>gp` — open the branch's PR in the browser.
- `<leader>pa` and `<C-n>`/`<C-e>`/etc. — Harpoon add/navigate (harpoon2 branch, Telescope-integrated).
- `<leader>st` — Neo-tree floating file explorer.
- `<leader>a*` — ClaudeCode integration (`<leader>ao` open, `<leader>am` select model, `<leader>ada`/`<leader>add` accept/deny diff).
- `<C-hjkl>` — window navigation (note: `<C-l>` is also bound by Harpoon to the Telescope marks menu).
