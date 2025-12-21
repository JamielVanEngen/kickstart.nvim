return {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  ft = 'markdown',
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    frontmatter = {
      enabled = false,
    },
    note_id_func = function(title)
      return title
    end,
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
  },
}
