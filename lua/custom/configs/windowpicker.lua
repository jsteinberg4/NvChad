local M = {}

M.keys = {
  {
    "<leader>pw",
    function()
      local picked_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
      vim.api.nvim_set_current_win(picked_id)
    end,
    desc = "[P]ick [W]indow",
  },
}

M.opts = {
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
}

return M
