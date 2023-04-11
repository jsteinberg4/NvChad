-- Configs for null-ls
local opts = {}
local nls = require "null-ls"

opts.root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git")

-- NOTE: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
opts.sources = {
  -- WARN: These must be installed globally or via Mason
  -- Completion
  nls.builtins.completion.spell,
  -- Diagnostics
  nls.builtins.diagnostics.jsonlint,
  nls.builtins.diagnostics.markdownlint,
  nls.builtins.diagnostics.pylint,
  nls.builtins.diagnostics.write_good, -- "English prose linter"
  -- Formatters
  nls.builtins.formatting.autoflake,
  nls.builtins.formatting.black,
  -- nls.builtins.formatting.shfmt,
  nls.builtins.formatting.stylua,
  -- Hover
  nls.builtins.hover.dictionary, -- Definitions
  nls.builtins.hover.printenv, -- Show env values
}

-- Setup format on save
-- SEE: https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
opts.on_attach = function(client, bufnr)
  -- you can reuse a shared lspconfig on_attach callback here
  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
        vim.lsp.buf.format {
          bufnr = bufnr,
          filter = function(c)
            return c.name == "null-ls"
          end,
        }
      end,
    })
  end
end

return opts
