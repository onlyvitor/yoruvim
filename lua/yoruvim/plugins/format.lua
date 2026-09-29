return {
  {
    "stevearc/conform.nvim",
    lazy = false,
    cmd = { "Format", "FormatToggle" },
    config = function()
      local conform = require("conform")
      local autoformat = false
      conform.setup({
        formatters_by_ft = {
          c = { "clang_format" }, cpp = { "clang_format" }, rust = { "rustfmt" },
          javascript = { "prettier" }, javascriptreact = { "prettier" },
          typescript = { "prettier" }, typescriptreact = { "prettier" },
          json = { "prettier" }, jsonc = { "prettier" }, markdown = { "prettier" },
          lua = { "stylua" }, sh = { "shfmt" }, bash = { "shfmt" },
        },
        default_format_opts = { lsp_format = "fallback", timeout_ms = 3000 },
        format_on_save = function(bufnr)
          if autoformat and vim.bo[bufnr].buftype == "" then
            return { lsp_format = "fallback", timeout_ms = 3000 }
          end
        end,
      })
      vim.api.nvim_create_user_command("Format", function()
        conform.format({ async = true, lsp_format = "fallback" })
      end, { desc = "Formatar arquivo atual" })
      vim.api.nvim_create_user_command("FormatToggle", function()
        autoformat = not autoformat
        vim.notify("Formatacao ao salvar: " .. (autoformat and "ligada" or "desligada"))
      end, { desc = "Alternar formatacao ao salvar" })
    end,
  },
}
