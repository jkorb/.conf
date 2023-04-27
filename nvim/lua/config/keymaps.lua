-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

local utils = require("config.utils")


-- stylua: ignore start
map("n", "[<space>", function() utils.insert_blank_line(-1) end, { desc = "Insert blank line above", silent = true })
map("n", "]<space>", function() utils.insert_blank_line(0) end, { desc = "Insert blank line below", silent = true })
map("n", "<space>cf", "gw", { desc = "Format text" } )
map("v", "<space>cf", "gw", { desc = "Format text" } )
