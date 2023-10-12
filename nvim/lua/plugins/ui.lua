return {
  -- {
  --   "navarasu/onedark.nvim",
  --   opts = {
  --     style = "darker",
  --     transparent = true,
  --     highlights = {
  --       ["@text.math"] = { fg = "$purple" },
  --       ["@text.environment"] = { fg = "$cyan" },
  --       ["@text.environment.name"] = { fg = "$yellow" },
  --     },
  --   },
  -- },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = true,
    },
  },
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "onedark",
  --   },
  -- },
  {
    "nvim-lualine/lualine.nvim",
    -- event = "VeryLazy",
    init = function()
      require("config.evil_lualine")
    end,
    -- opts = function()
    --   return {}
    -- end,
  },
  {
    "folke/noice.nvim",
    -- enabled = false,
    opts = {
      cmdline = {
        view = "cmdline",
        format = {
          cmdline = { pattern = "^:", icon = "", lang = "vim" },
        },
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000",
    },
  },
}
