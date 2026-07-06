-- Personal conform.nvim config. conform.nvim is already installed and set up by
-- the base config (SECTION 7); this file loads last and re-runs setup to override
-- it (vim.pack has no opts-merge). It restores format-on-save (all filetypes except
-- c/cpp — upstream made it opt-in/off) and adds the personal formatters.
require('conform').setup {
  notify_on_error = false,
  format_on_save = function(bufnr)
    -- Disable autoformat for languages without a well-standardized style.
    local disable_filetypes = { c = true, cpp = true }
    local lsp_format_opt = disable_filetypes[vim.bo[bufnr].filetype] and 'never' or 'fallback'
    return { timeout_ms = 500, lsp_format = lsp_format_opt }
  end,
  default_format_opts = {
    lsp_format = 'fallback',
  },
  formatters_by_ft = {
    lua = { 'stylua' },
    xml = { 'xmlformatter' },
    yml = { 'yamlfix' },
  },
  formatters = {
    xmlformatter = {
      prepend_args = { '--indent', '4', '--blanks', '--correct', 'True' },
    },
  },
}
