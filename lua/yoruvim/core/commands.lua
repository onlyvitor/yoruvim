local project = require("yoruvim.utils.project")

vim.api.nvim_create_user_command("Build", function() project.build() end, { desc = "Compilar projeto ou arquivo atual" })
vim.api.nvim_create_user_command("Run", function() project.run() end, { desc = "Executar projeto ou arquivo compilado" })
vim.api.nvim_create_user_command("Diagnostics", function() Snacks.picker.diagnostics() end, { desc = "Procurar diagnosticos" })
