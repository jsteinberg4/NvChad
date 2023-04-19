local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = require("custom.configs.lsp_servers").lsp_server_names

for _, lsp in ipairs(servers) do
  -- Clangd needs special setup
  if lsp == "clangd" then
    -- Prevent offset_encoding error with clangd
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428
    -- Check offset encoding with this lua snippet:
    -- vim.lsp.get_client_by_id(client_id).offset_encoding
    local clang_capabilities = {}
    for k, v in pairs(capabilities) do
      clang_capabilities[k] = v
    end
    clang_capabilities.offset_encoding = { "utf-16" }
    clang_capabilities.offsetEncoding = { "utf-16" }
    lspconfig.clangd.setup {
      on_attach = on_attach,
      capabilities = clang_capabilities,
    }
  elseif lsp ~= "lua_ls" then -- Don't overwrite the NvChad lua_ls config
    lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end
end

-- Without the loop, you would have to manually set up each LSP
--
-- lspconfig.html.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }
--
-- lspconfig.cssls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }
