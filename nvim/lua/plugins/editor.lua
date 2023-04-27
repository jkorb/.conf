return {
  {
    "alexghergh/nvim-tmux-navigation",
    lazy = true,
    event = "VimEnter",
    opts = {
      disable_when_zoomed = true,
    },
    keys = {
      { "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>" },
      { "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>" },
      { "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>" },
      { "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>" },
    },
  },
  {
    "lewis6991/spaceless.nvim",
    lazy = true,
    event = "InsertLeave",
  },
  {
    "jamessan/vim-gnupg",
  },
  {
    "folke/zen-mode.nvim",
    lazy = true,
    event = "BufEnter",
    opts = {
      window = {
        backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        width = 120, -- width of the Zen window
        height = 1, -- height of the Zen window
      },
    },
  },
  {
    "gbprod/cutlass.nvim",
    event = "BufEnter",
    opts = {
      cut_key = "x",
      exclude = { "ns", "nS" },
    },
  },
  {
    "echasnovski/mini.bracketed",
    -- lazy = true,
    -- event = "VeryLazy",
    config = function(_, opts)
      require("mini.bracketed").setup(opts)
    end,
  },
}
