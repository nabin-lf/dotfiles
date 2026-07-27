-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}
local overrides = require "configs.overrides"
M.base46 = {
  theme = "tokyonight",
  transparency = true,

  -- Match the blue NORMAL-mode accent across the dashboard.
  hl_override = {
    AlphaHeader = { fg = "#89b4fa" },
    AlphaButtons = { fg = "#cdd6f4" },
    AlphaFooter = { fg = "#89b4fa" },
  },

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
--}

M.ui = overrides.ui

return M
