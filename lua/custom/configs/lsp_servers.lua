-- Listing of language servers to install/configure
local M = {}

-- Names for installing via mason
-- NOTE: check MasonUI for names
M.mason_servers = {
  -- LSP's
  "bash-language-server",
  "clangd",
  "css-lsp",
  "eslint-lsp", -- Optional
  "html-lsp",
  "json-lsp",
  "lua-language-server",
  "marksman", -- Markdown
  "pyright",
  "yaml-language-server",
  -- Linters
  "pylint",
  "jsonlint",
  "markdownlint",
  "write-good",
  -- Formatters
  "autoflake",
  "black",
  "stylua",
  "usort",
}

-- Names for lspconfig
-- NOTE: see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- WARN: Don't add 'lua_ls'. It is already configured by NvChad.
M.lsp_server_names = {
  "bashls",
  "clangd",
  "cmake",
  "cssls",
  "eslint",
  "jsonls",
  "html",
  "marksman",
  "pyright",
  "yamlls",
}

-- Names of TreeSitter modules
-- NOTE: see https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
M.treesitter_servers = {
  "bash",
  "c",
  "css",
  "gitignore",
  "html",
  "javascript",
  "json",
  "jsonc",
  "lua",
  "luap",
  "markdown",
  "markdown_inline",
  "python",
  "regex",
  "tsx",
  "typescript",
  "vim",
  "yaml",
}

return M
