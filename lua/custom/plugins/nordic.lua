-- Nordic colorscheme (active theme). This file is loaded last (via
-- `require 'custom.plugins'` in init.lua SECTION 10), after the base config's
-- tokyonight `colorscheme` call, so activating nordic here wins.
vim.pack.add { 'https://github.com/AlexvZyl/nordic.nvim' }

require('nordic').setup {}
vim.cmd.colorscheme 'nordic'
