-- This file adds any additional plugins
-- Plugin definitions follow the folke/lazy.nvim spec
local plugins = {
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = { delay = 200 },
    config = function(_, opts)
      -- TODO: Extract to config file
      require("illuminate").configure(opts)
      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end

      map("]]", "next")
      map("[[", "prev")

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
    keys = {
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },
    },
  },
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
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufNewFile", "BufRead", "BufReadPost" },
    opts = require "custom.configs.todo-comments",
    -- stylua: ignore
    config = function(_, opts) require("todo-comments").setup(opts) end,
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
  { -- surround operators
    "echasnovski/mini.surround",
    -- TODO : Keybindings
    keys = {},
    config = function(_, opts)
      require("mini.surround").setup(opts)
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        -- TODO: Format on write
        "jose-elias-alvarez/null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "mason.nvim" },
        -- stylua: ignore
        opts = function() return require "custom.configs.null-ls" end,
      },
      {
        "folke/neoconf.nvim",
        cmd = "Neoconf",
        config = true,
        opts = {
          global_settings = "neoconf-global.json",
        },
      },
      { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
    },
    config = function()
      require "custom.configs.pre-lspconfig"
      -- From: https://nvchad.com/docs/config/lsp
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { { "p00f/nvim-ts-rainbow", lazy = true } },
    opts = require("custom.configs.treesitter").opts,
  },
  { -- Better notification messages (popups)
    "rcarriga/nvim-notify",
    keys = require("custom.configs.nvim-notify").keys,
    opts = require("custom.configs.nvim-notify").opts,
    init = require("custom.configs.nvim-notify").init,
  },
  {
    -- add indent guides on bank lines
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      char = "│",
      show_trailing_blankline_indent = false,
      show_current_context = false,
      filetype_exclude = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "lazy",
      },
    },
  },
  {
    -- better window movement
    "s1n7ax/nvim-window-picker",
    version = "v1.*",
    keys = require("custom.configs.windowpicker").keys,
    opts = require("custom.configs.windowpicker").opts,
  },
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
  {
    -- VSCode like debug UI
    "rcarriga/nvim-dap-ui",
    cmd = { "DapContinue" }, -- TODO: may want to change these commands
    dependencies = {
      {
        "mfussenegger/nvim-dap",
        opts = require("custom.configs.dap").nvim_dap.opts,
        config = require("custom.configs.dap").nvim_dap.config,
      },
      {
        "mfussenegger/nvim-dap-python",
        config = require("custom.configs.dap").dap_python.config,
      },
    },
  },

  {
    -- TODO: Opts?
    "windwp/nvim-spectre",
    cmd = "Spectre",
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)", silent = true },
      { "<leader>sw", function() require("spectre").open_visual { select_word = true } end, desc = "Search current word (Spectre)", silent = true },
      { "<leader>sw", "<ESC><CMD>lua require('spectre').open_visual()<CR>", desc = "Search current word (Spectre)", silent = true, mode = "v" },
      { "<leader>sp", function() require("spectre").open_file_search { select_word = true } end, desc = "Search on current file (Spectre)", silent = true },
    },
  },
}

return plugins
