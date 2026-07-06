-- Neogit git panel. vim.pack has no lazy cmd/keys loading, so it loads eagerly;
-- the keymap still opens it on demand. plenary is required; diffview adds diff
-- integration. (Telescope, mini.pick, snacks are already available for pickers.)
vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/sindrets/diffview.nvim',
  'https://github.com/NeogitOrg/neogit',
}

require('neogit').setup {}

vim.keymap.set('n', '<leader>gg', '<cmd>Neogit kind=floating<cr>', { desc = '[G]it panel' })
