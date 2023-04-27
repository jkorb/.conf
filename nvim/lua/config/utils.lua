local M = {}

-- 0 means below and -1 means above
function M.insert_blank_line(direction)
  local pos = vim.api.nvim_win_get_cursor(0)

  vim.api.nvim_buf_set_lines(0, pos[1] + direction, pos[1] + direction, false, { "" })
end

function M.map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

return M
