local M = {}

M.keys = {
  {
    "<leader>un",
    function()
      require("notify").dismiss {
        silent = true,
        pending = true,
      }
    end,
    desc = "Delete all Notifications",
  },
}

M.opts = {
  timeout = 3000,
  max_height = function()
    return math.floor(vim.o.lines * 0.75)
  end,
  max_width = function()
    return math.floor(vim.o.columns * 0.75)
  end,
}

M.init = function()
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
      vim.notify = require "notify"
    end,
  })
end

return M
