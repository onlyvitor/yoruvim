vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("yoruvim.core.options")
require("yoruvim.core.autocmds")
require("yoruvim.core.keymaps")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local result = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
  if vim.v.shell_error ~= 0 then
    error("Falha ao instalar lazy.nvim. Verifique Git e a rede:\n" .. result)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("yoruvim.plugins", {
  checker = { enabled = false },
  change_detection = { notify = false },
})

local theme = require("yoruvim.core.theme")
theme.setup()

require("yoruvim.core.commands")
