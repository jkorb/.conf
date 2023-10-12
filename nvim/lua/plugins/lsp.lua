return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {},
        lua_ls = {
          -- mason = false, -- set to false if you don't want this server to be installed with mason
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
        bashls = {},
        pyright = {},
        marksman = {},
        texlab = {
          settings = {
            texlab = {
              rootDirectory = nil,
              build = {
                executable = "latexmk",
                args = { "-pdflatex", "-synctex=1", "%f" },
                onSave = false,
                forwardSearchAfter = false,
              },
              forwardSearch = {
                executable = "zathura",
                args = {
                  "--synctex-editor-command",
                  [[nvim --headless -c "TexlabInverseSearch '%{input}' %{line}"]],
                  "--synctex-forward",
                  "%l:1:%f",
                  "%p",
                },
              },
              chktex = {
                onOpenAndSave = true,
                onEdit = false,
              },
              formatterLineLength = 80,
            },
          },
        },
      },
    },
  },
  {
    "jkorb/ltex_extra.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    ft = { "plaintex", "tex", "latex", "bib", "markdown", "mail", "text", "gitcommit" },
    branch = "switchLanguage-feature",
    opts = {
      path = vim.fn.stdpath("config") .. "/spell",
      server_opts = {
        filetypes = { "plaintex", "tex", "latex", "bib", "markdown", "mail", "text", "gitcommit" },
        settings = {
          ltex = {
            checkFrequency = "edit",
            completionEnabled = true,
          },
        },
      },
    },
  },
}
