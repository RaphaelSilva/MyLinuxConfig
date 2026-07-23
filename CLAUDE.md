# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Personal Neovim configuration (dotfiles), intended to be used as `~/.config/nvim`. The actual config lives under `nvim/`. There is no build system, linter, or test suite — this is Lua configuration for the editor, not an application. Comments in the config are written in Portuguese.

## Plugin manager

Plugins are managed by `lazy.nvim`, bootstrapped directly in `nvim/init.lua` (clones itself on first run if not present). Plugin specs live one-per-file under `nvim/lua/plugins/`; `require("lazy").setup("plugins")` in `init.lua` auto-loads every spec in that directory. To add a plugin, drop a new file in `nvim/lua/plugins/` returning a lazy.nvim spec table — no central registry file needs editing.

Installed plugin versions are pinned in `nvim/lazy-lock.json`. This file is a lockfile, not something to hand-edit — it's updated by running `:Lazy sync` inside Neovim.

## Structure

- `nvim/init.lua` — entry point: loads `core.options`, bootstraps lazy.nvim, then loads all plugin specs.
- `nvim/lua/core/options.lua` — global `vim.opt` settings (numbering, tabs, mouse, encoding).
- `nvim/lua/plugins/*.lua` — one lazy.nvim plugin spec per file (LSP, Telescope, DAP, colorscheme, tmux navigation).

## LSP setup (`nvim/lua/plugins/lsp.lua`)

Target editor is **Neovim 0.9.5**, so plugin versions matter. Everything in the LSP stack is pinned to its last 1.x line for 0.9 compatibility (the 2.x lines require Neovim 0.10/0.11+): `mason.nvim` → tag `v1.11.0` (2.x breaks the registry download on 0.9.5 with `E5560`), `nvim-lspconfig` → tag `v1.8.0`. `mason-lspconfig` is intentionally **not used** — its 2.x line dropped `setup_handlers` and requires Neovim 0.11+. Instead, `mason.nvim` only installs the server binaries and servers are configured directly via `lspconfig`.

Server binaries (`pyright`, `typescript-language-server`) are npm packages, so **Node/npm must be on `PATH`** for Mason to install them.

To add a server, add an entry to the `servers` table in `lsp.lua` mapping the lspconfig name to the Mason package name (e.g. `ts_ls = "typescript-language-server"`). That single table drives both auto-install (via the `mason-registry` refresh loop) and `lspconfig[...].setup{}`. Keybindings (`<leader>gd`, `K`, `<leader>rn`, `<leader>ca`, `[d`/`]d`) are attached via the shared `on_attach` function.

Java (`jdtls`) is deliberately out of scope: it needs a JDK 17+ on the system and doesn't work well through plain `lspconfig` — it wants the dedicated `nvim-jdtls` plugin.

## Testing changes

There's no automated test suite. To verify a config change, open Neovim with this config and exercise the relevant keymap/plugin manually (e.g. `nvim -u nvim/init.lua`) or run `:Lazy sync` / `:checkhealth` to catch plugin/config errors.
