local M = {}

M.nvim_dap = {
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
}

M.dap_python = {
  config = function(_, opts)
    -- Virtualenv should contain debugpy
    require("dap-python").setup(vim.g.python3_host_prog)
  end,
}

-- nvim-dap-ui
M.ui = {}

return M
