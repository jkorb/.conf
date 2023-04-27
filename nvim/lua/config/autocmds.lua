-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_custom_" .. name, { clear = true })
end

local map = require("config.utils").map

vim.api.nvim_create_autocmd("FileType", {
  -- group = augroup("filetype_keybinds"),
  pattern = { "plaintex", "latex", "tex" },
  callback = function()
    vim.api.nvim_buf_create_user_command(0, "TexlabClean", function(_)
      local arguments = vim.lsp.util.make_text_document_params()
      vim.lsp.buf.execute_command({ command = "texlab.cleanAuxiliary", arguments = { arguments } })
    end, { desc = "Texlab: clean" })

    vim.api.nvim_buf_create_user_command(0, "TexlabPurge", function(_)
      local arguments = vim.lsp.util.make_text_document_params()
      vim.lsp.buf.execute_command({ command = "texlab.cleanArtifacts", arguments = { arguments } })
    end, { desc = "Texlab: purge" })

    map("n", "<leader>mc", "<cmd>TexlabBuild<cr>", { desc = "Texlab: build" })
    map("n", "<leader>mx", "<cmd>TexlabClean<cr>", { desc = "Texlab: clean" })
    map("n", "<leader>mX", "<cmd>TexlabPurge<cr>", { desc = "Texlab: purge" })
    map("n", "<leader>mv", "<cmd>TexlabForward<cr>", { desc = "Texlab: view" })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  -- group = augroup("filetype_keybinds"),
  pattern = { "plaintex", "tex", "latex", "bib", "markdown", "mail", "txt", "gitcommit" },
  callback = function()
    map("n", "<leader>ml", "<cmd>LtexSwitchLang<cr>", { desc = "Ltex-ls: Switch language" })
  end,
})
