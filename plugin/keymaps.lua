-- Personal keymaps, kept out of init.lua so upstream kickstart syncs cleanly.
-- Sourced automatically by Neovim from `plugin/` on startup.

-- Keep the cursor centered when scrolling half a page.
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Move the cursor to the middle when scrolling up' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Move the cursor to the middle when scrolling down' })

-- Open the current repo's origin URL in the browser (converts SSH -> HTTPS).
vim.keymap.set('n', '<leader>go', function()
  -- Get origin URL
  local url = vim.fn.system('git config --get remote.origin.url 2>/dev/null'):gsub('%s+$', '')

  if url == '' then
    vim.notify('No git origin found.', vim.log.levels.ERROR)
    return
  end

  -- Convert SSH → HTTPS
  if url:match '^git@' then
    -- git@github.com:user/repo.git → https://github.com/user/repo
    url = url:gsub('^git@([^:]+):(.+)$', 'https://%1/%2')
    url = url:gsub('%.git$', '')
    vim.notify(url)
  else
    -- https://github.com/user/repo.git → https://github.com/user/repo
    url = url:gsub('%.git$', '')
  end

  vim.fn.jobstart({ 'xdg-open', url }, { detach = true })
end, {
  desc = '[G]it [O]pen repository',
})

-- Open the current branch's pull request in the browser.
vim.keymap.set('n', '<leader>gp', function() vim.fn.jobstart({ 'gh', 'pr', 'view', '--web' }, { detach = true }) end, {
  desc = '[G]it open [P]ull request',
})
