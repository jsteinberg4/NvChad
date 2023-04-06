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
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufNewFile", "BufRead", "BufReadPost" },
    opts = require "custom.configs.todo-comments",
    config = function(_, opts)
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
    dependencies = {
      { "p00f/nvim-ts-rainbow", lazy = true },
    },
    opts = {
      -- This seems related to ts_context_commentstring
      context_commentstring = { enable = true, enable_autocmd = false },
      ensure_installed = require("custom.configs.lsp_servers").treesitter_servers,
      rainbow = { -- Rainbow brackets config
        enable = true,
        -- disable = {} -- List[str] of languages to disable this for
        extended_mode = true, -- also highlight non-braket delimiters
        max_file_lines = 1000, -- Disable for files over N lines
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-Space>",
          node_incremental = "<C-Space>",
          scope_incremental = "<nop>",
          node_decremental = "<BS>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>a"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>A"] = "@parameter.inner",
          },
        },
      },
    },
  },
  { -- Better notification messages (popups)
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss { silent = true, pending = true }
        end,
        desc = "Delete all Notifications",
      },
    },
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          vim.notify = require "notify"
        end,
      })
    end,
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
    keys = {
      {
        "<leader>pw",
        function()
          local picked_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
          vim.api.nvim_set_current_win(picked_id)
        end,
        desc = "[P]ick [W]indow",
      },
    },
    opts = {
      include_current = false,
      autoselect_one = true,
      filter_rules = {
        bo = {
          -- ignore neo-tree or notify windows
          filetype = { "neo-tree", "neo-tree-popup", "notify" },
          -- Ignore terminal and quickfix buffers
          buftype = { "terminal", "quickfix" },
        },
      },
      other_win_hl_color = "#e35e4f",
    },
  },
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
  {
    -- VSCode like debug UI
    "rcarriga/nvim-dap-ui",
    dependencies = {
      {
        "mfussenegger/nvim-dap",
        opts = {},
        config = function(_, opts)
          local DAP = require "dap"
          local DAPUI = require "dapui"

          -- Configure dap-ui to auto open/close with DAP
          DAP.listeners.after.event_initialized["dapui_config"] = function()
            DAPUI.open()
          end
          DAP.listeners.before.event_terminated["dapui_config"] = function()
            DAPUI.close()
          end
          DAP.listeners.before.event_exited["dapui_config"] = function()
            DAPUI.close()
          end
          DAPUI.setup()
        end,
      },
      {
        "mfussenegger/nvim-dap-python",
        config = function(_, opts)
          -- Virtualenv should contain debugpy
          require("dap-python").setup(vim.g.python3_host_prog)
        end,
      },
    },
    cmd = { "DapContinue" }, -- TODO: may want to change these commands
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require "null-ls"
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        -- NOTE: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
        sources = {
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
          nls.builtins.formatting.shfmt,
          nls.builtins.formatting.stylua,
          -- Hover
          nls.builtins.hover.dictionary, -- Definitions
          nls.builtins.hover.printenv, -- Show env values
        },
      }
    end,
  },
}

return plugins
