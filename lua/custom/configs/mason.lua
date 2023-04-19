local M = {}

M.opts = function(_, opts)
  local nvchad_opts = require "plugins.configs.mason"
  nvchad_opts.ensure_installed = require("custom.configs.lsp_servers").mason_servers
  return nvchad_opts
end

return M
