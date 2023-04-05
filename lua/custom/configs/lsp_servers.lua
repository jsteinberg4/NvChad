-- Listing of language servers to install/configure
local M = {}

-- Names for installing via mason
M.mason_servers = {
  "lua-language-server",
  "stylua",
  "pylint",
  "black",
  "autoflake",
  "usort",
}

-- Names for lspconfig
M.lsp_server_names = {
  "html",
  "cssls",
  "clangd",
  -- "lua_ls",
  "pyright",
}

return M
