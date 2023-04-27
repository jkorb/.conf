return {
  {
    "L3MON4D3/LuaSnip",
    opts = {
      store_selection_keys = "<Tab>",
      region_check_events = "InsertEnter",
      delete_check_events = "InsertLeave",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-cmdline",
      "kdheepak/cmp-latex-symbols",
      "jc-doyle/cmp-pandoc-references",
      "jkorb/cmp_email.nvim",
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "cmp_email" } }))
    end,
  },
}
