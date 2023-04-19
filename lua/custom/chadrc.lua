-- This file overwrites the default configuration options for NVCha
-- This youtube video explains configuration very well:
-- https://www.youtube.com/watch?v=Mtgo-nP_r8Y
local M = {}
M.ui = {
  theme = "nord",
  -- TODO: Find a tolerable light theme to toggle to
  theme_toggle = { "nord", "onenord_light" },
  hl_override = {
    -- Reasoning for the CursorLine override:
    -- https://github.com/NvChad/NvChad/issues/863
    CursorLine = {
      bg = "one_bg",
    },
  },
}
-- Add any additional plugins here as a table
M.plugins = "custom.plugins"
-- Add keymaps here, as a table
M.mappings = require "custom.mappings"
return M
