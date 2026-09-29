local map = vim.keymap.set
local function picker(name, opts)
  return function()
    Snacks.picker[name](opts)
  end
end

map("n", "<leader>fs", "<cmd>write<cr>", { desc = "Salvar arquivo" })
map("n", "<leader>q", "<cmd>confirm qall<cr>", { desc = "Sair" })
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "Novo arquivo" })
map("n", "<leader>e", function() Snacks.explorer() end, { desc = "Explorador" })
map("n", "<leader>ff", picker("files"), { desc = "Procurar arquivos" })
map("n", "<leader>fg", picker("grep"), { desc = "Buscar texto no projeto" })
map("n", "<leader>fr", picker("recent"), { desc = "Arquivos recentes" })
map("n", "<leader>fp", picker("projects"), { desc = "Projetos recentes" })
map("n", "<leader>fc", picker("files", { cwd = vim.fn.stdpath("config") }), { desc = "Arquivos da configuracao" })
map("n", "<leader>fC", picker("commands"), { desc = "Procurar comandos" })

map("n", "<leader>bl", picker("buffers"), { desc = "Listar buffers" })
map("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Fechar buffer" })
map("n", "<leader>bb", "<cmd>bnext<cr>", { desc = "Proximo buffer" })
map("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Buffer anterior" })

map("n", "<leader>gg", picker("git_status"), { desc = "Status Git" })
map("n", "<leader>gd", picker("git_diff"), { desc = "Diff Git" })
map("n", "<leader>gh", picker("git_log"), { desc = "Historico Git" })
map("n", "<leader>gf", picker("git_log_file"), { desc = "Historico do arquivo" })
map("n", "<leader>gB", picker("git_branches"), { desc = "Branches Git" })

map("n", "<leader>ls", picker("lsp_symbols"), { desc = "Simbolos do arquivo" })
map("n", "<leader>lw", picker("lsp_workspace_symbols"), { desc = "Simbolos do projeto" })
map("n", "<leader>ld", picker("diagnostics"), { desc = "Diagnosticos do projeto" })
map("n", "<leader>ll", vim.diagnostic.open_float, { desc = "Diagnostico da linha" })
map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Proximo diagnostico" })
map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Diagnostico anterior" })
map("n", "]e", function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR }) end, { desc = "Proximo erro" })
map("n", "[e", function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR }) end, { desc = "Erro anterior" })

map("n", "<leader>cb", "<cmd>Build<cr>", { desc = "Compilar projeto" })
map("n", "<leader>cr", "<cmd>Run<cr>", { desc = "Executar projeto" })
map("n", "<leader>cf", "<cmd>Format<cr>", { desc = "Formatar arquivo" })
map("n", "<leader>cF", "<cmd>FormatToggle<cr>", { desc = "Alternar formatacao ao salvar" })
map("n", "<leader>cl", "<cmd>Lint<cr>", { desc = "Executar lint" })

local function terminal()
  Snacks.terminal.toggle(nil, { cwd = require("yoruvim.utils.project").root() })
end
map({ "n", "t" }, "<leader>tt", terminal, { desc = "Abrir ou ocultar terminal" })
map("t", "<C-h>", [[<C-\><C-n><C-w>h]], { desc = "Terminal para janela esquerda" })
map("t", "<C-j>", [[<C-\><C-n><C-w>j]], { desc = "Terminal para janela abaixo" })
map("t", "<C-k>", [[<C-\><C-n><C-w>k]], { desc = "Terminal para janela acima" })
map("t", "<C-l>", [[<C-\><C-n><C-w>l]], { desc = "Terminal para janela direita" })
map("n", "<leader>tk", function()
  if vim.bo.buftype == "terminal" then vim.cmd("bdelete!") end
end, { desc = "Fechar buffer de terminal" })

map("n", "<leader>ws", function()
  vim.wo.spell = not vim.wo.spell
  vim.notify("Corretor: " .. (vim.wo.spell and "ligado" or "desligado"))
end, { desc = "Alternar corretor ortografico" })
map("n", "<leader>wl", function()
  local langs = { "en", "pt-br", "en,pt-br" }
  local current = vim.bo.spelllang
  local next_lang = langs[((vim.fn.index(langs, current) + 1) % #langs) + 1]
  if next_lang:find("pt-br", 1, true) and #vim.api.nvim_get_runtime_file("spell/pt-br.utf-8.spl", false) == 0 then
    vim.notify("Instale pt-br.utf-8.spl conforme README.md", vim.log.levels.WARN)
    return
  end
  vim.bo.spelllang = next_lang
  vim.notify("Idioma do corretor: " .. next_lang)
end, { desc = "Alternar idioma en / pt-br / ambos" })
map("n", "<leader>uw", function() vim.wo.wrap = not vim.wo.wrap end, { desc = "Alternar quebra de linha" })
map("n", "<leader>un", function() vim.wo.relativenumber = not vim.wo.relativenumber end, { desc = "Alternar numeros relativos" })
map("n", "<leader>uc", function() vim.wo.cursorline = not vim.wo.cursorline end, { desc = "Alternar linha do cursor" })
for lhs, rhs in pairs({ ["<C-h>"] = "h", ["<C-j>"] = "j", ["<C-k>"] = "k", ["<C-l>"] = "l" }) do
  map("n", lhs, "<C-w>" .. rhs, { desc = "Ir para janela " .. rhs })
end
