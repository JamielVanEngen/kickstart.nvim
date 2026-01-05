return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    local harpoon = require 'harpoon'
    local ui = require 'harpoon.ui'
    local telescope = require 'telescope'

    harpoon.setup {}

    -- REQUIRED for Telescope integration
    telescope.load_extension 'harpoon'

    -- Add file to harpoon
    vim.keymap.set('n', '<leader>pa', function()
      harpoon:list():add()
    end, { desc = '[A]dd file to Harpoon' })

    -- Toggle quick menu
    vim.keymap.set('n', '<C-l>', function()
      telescope.extensions.harpoon.marks()
    end, { desc = '[H]arpoon (Telescope)' })

    -- File navigation
    vim.keymap.set('n', '<C-n>', function()
      harpoon:list():select(1)
    end)
    vim.keymap.set('n', '<C-e>', function()
      harpoon:list():select(2)
    end)
    vim.keymap.set('n', '<C-i>', function()
      harpoon:list():select(3)
    end)
    vim.keymap.set('n', '<C-o>', function()
      harpoon:list():select(4)
    end)
  end,
}
