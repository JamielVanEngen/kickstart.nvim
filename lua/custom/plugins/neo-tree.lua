-- Neo-tree file explorer (floating), plus lsp-file-operations and window-picker.
-- Icons come from the base config's mini.icons devicons mock (no nvim-web-devicons).
vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
  { src = 'https://github.com/s1n7ax/nvim-window-picker', version = vim.version.range '2.*' },
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = 'v3.x' },
  'https://github.com/antosha417/nvim-lsp-file-operations',
}

require('window-picker').setup {
  filter_rules = {
    include_current_win = false,
    autoselect_one = true,
    -- filter using buffer options
    bo = {
      -- if the file type is one of following, the window will be ignored
      filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
      -- if the buffer type is one of following, the window will be ignored
      buftype = { 'terminal', 'quickfix' },
    },
  },
}

require('lsp-file-operations').setup()

require('neo-tree').setup {
  event_handlers = {
    {
      event = 'neo_tree_buffer_enter',
      handler = function() vim.cmd [[setlocal relativenumber]] end,
    },
  },
  window = {
    position = 'float',
  },
  filesystem = {
    filtered_items = {
      visible = false,
      hide_dotfiles = false,
      hide_gitignored = true,
      hide_gituntracked = true,
    },
  },
}

vim.keymap.set('n', '<leader>st', '<cmd>Neotree reveal<CR>', { desc = '[S]earch using Neo [T]ree' })

vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    if vim.bo.buftype == '' then vim.cmd 'Neotree close' end
  end,
})
