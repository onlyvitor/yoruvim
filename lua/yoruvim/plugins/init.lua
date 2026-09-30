return {
  {
    "nvim-tree/nvim-web-devicons",
    lazy = false,
    priority = 950,
    opts = {},
  },
  {
    "folke/snacks.nvim",
    priority = 900,
    lazy = false,
    opts = {
      dashboard = {
        preset = {
          header = [[
▄██   ▄    ▄██████▄     ▄████████ ███    █▄   ▄█    █▄   ▄█    ▄▄▄▄███▄▄▄▄   
███   ██▄ ███    ███   ███    ███ ███    ███ ███    ███ ███  ▄██▀▀▀███▀▀▀██▄ 
███▄▄▄███ ███    ███   ███    ███ ███    ███ ███    ███ ███▌ ███   ███   ███ 
▀▀▀▀▀▀███ ███    ███  ▄███▄▄▄▄██▀ ███    ███ ███    ███ ███▌ ███   ███   ███ 
▄██   ███ ███    ███ ▀▀███▀▀▀▀▀   ███    ███ ███    ███ ███▌ ███   ███   ███ 
███   ███ ███    ███ ▀███████████ ███    ███ ███    ███ ███  ███   ███   ███ 
███   ███ ███    ███   ███    ███ ███    ███ ███    ███ ███  ███   ███   ███ 
 ▀█████▀   ▀██████▀    ███    ███ ████████▀   ▀██████▀  █▀    ▀█   ███   █▀  
                       ███    ███                                            
]],
          keys = {
              { key = "n", desc = "Novo arquivo", action = ":enew | startinsert", icon = "" },
              { key = "o", desc = "Abrir arquivo por caminho", action = function()
                vim.api.nvim_feedkeys(":edit ", "n", false)
               end, icon = "" },
              { key = "f", desc = "Procurar arquivos", action = function() Snacks.picker.files() end, icon = "" },
              { key = "p", desc = "Projetos recentes", action = function() Snacks.picker.projects() end, icon = "" },
              { key = "c", desc = "Configuracoes", action = function()
                Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
              end, icon = "" },
              { key = "q", desc = "Sair", action = ":qa", icon = "󰗎" },
          },
        },
        sections = { { section = "header" }, { section = "keys", gap = 1, padding = 1 } },
      },
      picker = {
        enabled = true,
        icons = {
          files = { enabled = true },
          git = {
            commit = "*", staged = "+", added = "A", deleted = "D",
            ignored = "!", modified = "M", renamed = "R",
            unmerged = "U", untracked = "?",
          },
          diagnostics = { Error = "E", Warn = "W", Hint = "H", Info = "I" },
        },
      },
      explorer = { enabled = true, trash = false },
      terminal = { enabled = true },
      bufdelete = { enabled = true },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
       icons = { mappings = true },
      spec = {
        { "<leader>f", group = "arquivos" },
        { "<leader>g", group = "git" },
        { "<leader>l", group = "lsp" },
        { "<leader>b", group = "buffers" },
        { "<leader>t", group = "terminal" },
        { "<leader>d", group = "debug" },
        { "<leader>c", group = "codigo" },
        { "<leader>w", group = "escrita" },
        { "<leader>u", group = "interface" },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local th = require("yoruvim.core.theme")
      local colors = th.lualine_colors()
      return {
        options = {
          theme = colors,
          globalstatus = true,
          component_separators = "",
          section_separators = "",
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff" },
          lualine_c = { { "buffers", max_length = function() return math.floor(vim.o.columns * 0.35) end } },
          lualine_x = { "diagnostics", {
            function() return vim.fn.wordcount().words .. " palavras" end,
            cond = function() return vim.tbl_contains({ "markdown", "text", "gitcommit" }, vim.bo.filetype) end,
          } },
          lualine_y = { "filetype" },
          lualine_z = { "location" },
        },
      }
    end,
  },
  { import = "yoruvim.plugins.treesitter" },
  { import = "yoruvim.plugins.completion" },
  { import = "yoruvim.plugins.format" },
  { import = "yoruvim.plugins.lint" },
  { import = "yoruvim.plugins.git" },
  { import = "yoruvim.plugins.debug" },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function() require("yoruvim.lsp") end,
  },
}
