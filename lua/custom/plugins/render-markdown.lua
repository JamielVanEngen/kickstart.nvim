-- render-markdown: prettier in-buffer Markdown rendering.
-- nvim-treesitter and mini.nvim (for icons) are already provided by the base config.
vim.pack.add { 'https://github.com/MeanderingProgrammer/render-markdown.nvim' }

require('render-markdown').setup {}
