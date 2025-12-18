return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'unifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      vim.keymap.set('n', '<leader>st', '<cmd>Neotree reveal float<CR>', { desc = '[S]earch using Neo [T]ree' })

      vim.api.nvim_create_autocmd('BufEnter', {
        callback = function()
          -- Close Neotree if it's open and we're in a normal file buffer
          if vim.bo.buftype == '' then
            vim.cmd 'Neotree close'
          end
        end,
        -- Add this to avoid issues with certain plugins or events
        -- events = {'BufEnter', 'BufWinEnter'},
        -- pattern = '*',
      })
    end,
  },
  {
    'antosha417/nvim-lsp-file-operations',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-neo-tree/neo-tree.nvim', -- makes sure that this loads after Neo-tree.
    },
    config = function()
      require('lsp-file-operations').setup()
    end,
  },
  {
    's1n7ax/nvim-window-picker',
    version = '2.*',
    config = function()
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
    end,
  },
}
