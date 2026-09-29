return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local parsers = {
        "c", "cpp", "rust", "javascript", "typescript", "tsx", "json",
        "lua", "markdown", "markdown_inline", "bash", "vimdoc",
      }
      if vim.fn.executable("tree-sitter") == 1
        and (vim.fn.executable("cc") == 1 or vim.fn.executable("gcc") == 1 or vim.fn.executable("clang") == 1) then
        require("nvim-treesitter").install(parsers)
      else
        vim.notify(
          "Treesitter: instale tree-sitter-cli (cargo install tree-sitter-cli) e um compilador C; depois execute :TSInstall",
          vim.log.levels.WARN
        )
      end
      local filetypes = {
        "c", "cpp", "rust", "javascript", "javascriptreact", "typescript",
        "typescriptreact", "json", "jsonc", "lua", "markdown", "bash", "sh", "vimdoc",
      }
      vim.api.nvim_create_autocmd("FileType", {
        pattern = filetypes,
        callback = function(args)
          if not pcall(vim.treesitter.start, args.buf) then return end
          if vim.tbl_contains({ "c", "cpp", "rust", "javascript", "javascriptreact", "typescript", "typescriptreact", "lua" }, vim.bo[args.buf].filetype) then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
