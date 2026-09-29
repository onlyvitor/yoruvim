return {
  {
    "mfussenegger/nvim-lint",
    lazy = false,
    cmd = "Lint",
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        javascript = { "eslint" }, javascriptreact = { "eslint" },
        typescript = { "eslint" }, typescriptreact = { "eslint" },
        rust = { "clippy" },
      }
      vim.api.nvim_create_user_command("Lint", function()
        local root = require("yoruvim.utils.project").root()
        if vim.bo.filetype == "rust" and vim.fn.executable("cargo") == 0 then
          vim.notify("Cargo nao encontrado", vim.log.levels.WARN)
          return
        end
        if vim.bo.filetype:match("^javascript") or vim.bo.filetype:match("^typescript") then
          if vim.fn.executable(root .. "/node_modules/.bin/eslint") == 0 and vim.fn.executable("eslint") == 0 then
            vim.notify("ESLint nao encontrado no projeto ou no PATH", vim.log.levels.WARN)
            return
          end
        end
        lint.try_lint(nil, { cwd = root })
      end, { desc = "Executar linters do tipo de arquivo" })
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = vim.api.nvim_create_augroup("YoruvimLint", { clear = true }),
        pattern = { "*.js", "*.jsx", "*.ts", "*.tsx" },
        callback = function()
          local root = require("yoruvim.utils.project").root()
          if vim.fn.executable(root .. "/node_modules/.bin/eslint") == 1 then
            lint.try_lint(nil, { cwd = root })
          end
        end,
      })
    end,
  },
}
