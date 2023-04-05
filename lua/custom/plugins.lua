-- This file adds any additional plugins
-- Plugin definitions follow the folke/lazy.nvim spec
local plugins = {
  {
    -- TODO: Automatically run MasonInstall{All?} if servers are not present
    "williamboman/mason.nvim",
    -- priority = 55, -- Force loading before mason-lspconfig
    opts = {
      ensure_installed = require("custom.configs.lsp_servers").mason_servers,
    },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim"},
    event = {"BufNewFile","BufRead", "BufReadPost"},
    opts = require("custom.configs.todo-comments"),
    config = function (_, opts)
      require("todo-comments").setup(opts)
    end,
  },
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
