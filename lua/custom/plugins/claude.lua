-- ClaudeCode integration.
vim.pack.add {
  'https://github.com/folke/snacks.nvim',
  'https://github.com/coder/claudecode.nvim',
}

require('claudecode').setup()

vim.keymap.set('n', '<leader>ao', '<cmd>ClaudeCode<CR>', { desc = 'Open Claudecode' })
vim.keymap.set('n', '<leader>am', '<cmd>ClaudeCodeSelectModel<CR>', { desc = 'Select Claude model' })
vim.keymap.set('n', '<leader>ada', '<cmd>ClaudeCodeDiffAccept<CR>', { desc = 'Accept diff changes' })
vim.keymap.set('n', '<leader>add', '<cmd>ClaudeCodeDiffDeny<CR>', { desc = 'Deny diff changes' })
