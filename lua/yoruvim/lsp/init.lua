local group = vim.api.nvim_create_augroup("YoruvimLsp", { clear = true })
vim.diagnostic.config({
  virtual_text = { spacing = 2, severity = { min = vim.diagnostic.severity.WARN } },
  underline = true,
  signs = true,
  severity_sort = true,
  update_in_insert = false,
})

vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })
vim.lsp.config("clangd", {
  cmd = { "clangd", "--background-index", "--clang-tidy" },
  root_markers = { "compile_commands.json", "compile_flags.txt", "CMakeLists.txt", "Makefile", ".git" },
})
vim.lsp.config("rust_analyzer", { settings = { ["rust-analyzer"] = { check = { command = "check" } } } })
vim.lsp.config("vtsls", {
  root_dir = function(bufnr, on_dir)
    if vim.fs.root(bufnr, { "deno.json", "deno.jsonc" }) then return end
    on_dir(vim.fs.root(bufnr, { "tsconfig.json", "jsconfig.json", "package.json", ".git" }) or vim.fn.getcwd())
  end,
})
vim.lsp.enable({ "clangd", "rust_analyzer", "vtsls", "jsonls", "lua_ls", "bashls" })

vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(args)
    local bufnr = args.buf
    local function map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
    end
    map("gd", function() Snacks.picker.lsp_definitions() end, "Ir para definicao")
    map("gD", function() Snacks.picker.lsp_declarations() end, "Ir para declaracao")
    map("gI", function() Snacks.picker.lsp_implementations() end, "Ir para implementacao")
    map("gr", function() Snacks.picker.lsp_references() end, "Buscar referencias")
    map("K", vim.lsp.buf.hover, "Documentacao")
    map("<leader>la", vim.lsp.buf.code_action, "Acao de codigo")
    map("<leader>lr", vim.lsp.buf.rename, "Renomear simbolo")
    map("<leader>lo", function()
      vim.lsp.buf.code_action({
        context = { only = { "source.organizeImports" }, diagnostics = {} },
        filter = function(action)
          return action.kind and action.kind:find("source.organizeImports", 1, true) == 1
        end,
        apply = true,
      })
    end, "Organizar imports")
  end,
})
