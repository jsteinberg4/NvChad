-- This file overwrites the default configuration options for NVCha
-- This youtube video explains configuration very well:
-- https://www.youtube.com/watch?v=Mtgo-nP_r8Y
local M = {}
M.ui = {
  theme = 'catppuccin',
  hl_override = {
    CursorLine = {
      bg = "one_bg",
    },
  },
  nvdash = {
    load_on_startup = true,
  },
}
-- Add any additional plugins here as a table
M.plugins = "custom.plugins"
-- Add keymaps here, as a table
M.mappings = require "custom.mappings"
return M
