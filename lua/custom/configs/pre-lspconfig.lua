-- Some plugins (e.g. folke/neoconf) must be set up before LSPConfig.
-- Do that here.
require("neoconf").setup {
  -- global_settings = "neoconf-global.json",
}

-- Setup order:
-- 1) Mason.nvim
-- 2) mason-lspconfig.nvim (if in use)
-- 3) neovim/nvim-lspconfig
-- https://github.com/williamboman/mason-lspconfig.nvim#setup
require("mason").setup(require("custom.configs.mason").opts(0, {}))
