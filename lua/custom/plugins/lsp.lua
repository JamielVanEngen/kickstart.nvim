-- Personal LSP servers + Mason-managed tools, kept out of init.lua so the base
-- config's `servers` table stays pristine. Servers are enabled with the native
-- Neovim 0.11+ API; nvim-lspconfig (installed by the base config) ships their
-- default configs under `lsp/` on the runtimepath. This file loads last, after
-- the base LSP section has already run mason.setup(), so no deferral is needed.

-- Give every enabled server blink.cmp's completion capabilities.
vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})

-- kotlin_lsp is an external binary (JetBrains intellij-server), not a Mason
-- package, so it is configured/enabled here but excluded from Mason installs.
vim.lsp.config('kotlin_lsp', {
  cmd = { 'env', 'IJ_JAVA_OPTIONS=-Xmx12g', 'intellij-server', '--stdio' },
})

vim.lsp.enable {
  'kotlin_lsp',
  'angularls',
  'yamlls',
  'lemminx',
  'markdown_oxide',
  'terraformls',
  'helm_ls',
  'jsonls',
}

-- Ensure the personal servers + tools are installed via Mason.
local mti = require 'mason-tool-installer'
mti.setup {
  run_on_start = false,
  ensure_installed = {
    -- LSP servers (Mason-installable; names map via mason-lspconfig)
    'angularls',
    'yamlls',
    'lemminx',
    'markdown_oxide',
    'terraformls',
    'helm_ls',
    'jsonls',
    -- Formatters / linters
    'xmlformatter',
    'gofumpt',
    'yamlfmt',
    'prettier',
    'prettierd',
    'fixjson',
    'ktfmt',
    'ktlint',
    'squawk',
  },
}
mti.check_install(false)
