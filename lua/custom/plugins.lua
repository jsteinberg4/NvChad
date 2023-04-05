-- This file adds any additional plugins
-- Plugin definitions follow the folke/lazy.nvim spec
local plugins = {
  -- {
  --   "williamboman/mason.nvim",
  --   priority = 55, -- Force loading before mason-lspconfig
  --   opts = {
  --     ensure_installed = {
  --       "stylua",
  --       "pylint",
  --       "black",
  --       "autoflake",
  --       "usort",
  --     },
  --   },
  -- },
  -- {
  --   "williamboman/mason-lspconfig.nvim",
  --   priority = 50, -- Force loading *after* mason.nvim
  --   opts = {
  --     -- automatic_installation = true,
  --     ensure_installed = {
  --       "lua_ls", -- "lua-language-server"
  --       "pyright",
  --     },
  --   },
  --   cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
  -- },
  -- { -- surround operators
  --   "echasnovski/mini.surround",
  --   -- TODO : Keybindings
  --   lazy = false,
  --   keys = {},
  --   config = function(_, opts)
  --     require("mini.surround").setup(opts)
  --   end,
  -- },
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- From: https://nvchad.com/docs/config/lsp
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

}

return plugins
