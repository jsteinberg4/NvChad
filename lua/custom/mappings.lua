-- Documentation: 
-- https://nvchad.com/docs/config/mappings


local M = {}

-- Use this to disable NvChad's default keymappings
M.disabled = {
  -- Example:
  -- n = {
  --     ["<leader>h"] = "",
  --     ["<C-a>"] = ""
  -- }
}

M.nvim_mappings = {
  -- Mappings for basic NVim functions
  n = {
    ["<Space>"] = {"<Nop>", "Space does nothing in normal mode"},
    ["J"] = {"mzJ`z", "Join lines w/o moving cursor"},
    ["<leader>lz"] = {"<CMD>Lazy<CR>", "Open [l]a[z]y UI", opts = {silent = true}},
    ["gg"] = {"ggzz", "GOTO top, center cursor" },
    ["G"] = {"Gzz", "GOTO bottom, center cursor" },
    ["<C-d>"] = { "<C-d>zz", "Page down, center cursor" },
    ["<C-u>"] = { "<C-u>zz", "Page up, center cursor" },
    ["n"] = {"nzzzv", "Keep cursor centered while searching"},
    ["N"] = {"Nzzzv", "Center cursor while searching" },
  },
  v = {
    ["<Space>"] = {"<Nop>", "Space does nothing in visual mode"},
    ["J"] = {":m '>+1<CR>gv=gv", "Move selected line down", opts = { silent = true }},
    ["K"] = {":m '<-2<CR>gv=gv", "Move selected line up", opts = { silent = true }},
  },
}

return M
