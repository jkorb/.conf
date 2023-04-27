return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {},
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
    ft = { "plaintex", "tex", "latex", "bib", "markdown", "mail", "txt", "gitcommit" },
    branch = "switchLanguage-feature",
    opts = {
      path = vim.fn.stdpath("config") .. "/spell",
      server_opts = {
        filetypes = { "plaintex", "tex", "latex", "bib", "markdown", "mail", "txt", "gitcommit" },
        settings = {
          ltex = {
            checkFrequency = "save",
            completionEnabled = true,
          },
        },
      },
    },
  },
}
