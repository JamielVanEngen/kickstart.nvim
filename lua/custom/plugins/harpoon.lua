-- Harpoon (harpoon2 branch), Telescope-integrated.
vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  { src = 'https://github.com/ThePrimeagen/harpoon', version = 'harpoon2' },
}

local harpoon = require 'harpoon'
local telescope = require 'telescope'

harpoon:setup {}

-- REQUIRED for Telescope integration
telescope.load_extension 'harpoon'

-- Add file to harpoon
vim.keymap.set('n', '<leader>pa', function() harpoon:list():add() end, { desc = '[A]dd file to Harpoon' })

-- Toggle quick menu (Telescope)
vim.keymap.set('n', '<C-l>', function() telescope.extensions.harpoon.marks() end, { desc = '[H]arpoon (Telescope)' })

-- File navigation
vim.keymap.set('n', '<C-n>', function() harpoon:list():select(1) end)
vim.keymap.set('n', '<C-e>', function() harpoon:list():select(2) end)
vim.keymap.set('n', '<C-i>', function() harpoon:list():select(3) end)
vim.keymap.set('n', '<C-o>', function() harpoon:list():select(4) end)
