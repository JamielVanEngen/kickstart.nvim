-- Obsidian note-taking. Loads eagerly (vim.pack has no `ft` lazy-loading);
-- functionality only engages in the configured markdown workspaces.
vim.pack.add { { src = 'https://github.com/obsidian-nvim/obsidian.nvim', version = vim.version.range '*' } }

---@module 'obsidian'
---@type obsidian.config
require('obsidian').setup {
  frontmatter = {
    enabled = false,
  },
  note_id_func = function(title) return title end,
  legacy_commands = false, -- this will be removed in the next major release
  new_notes_location = 'notes_subdir',
  notes_subdir = 'Notes',
  workspaces = {
    {
      name = 'Second Brain',
      path = '~/Documents/Second-Brain',
    },
  },
  templates = {
    folder = 'Other/Templates',
  },
}
