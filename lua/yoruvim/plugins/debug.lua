return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Alternar breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Iniciar ou continuar" },
      { "<leader>ds", function() require("dap").step_over() end, desc = "Passo sobre" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Passo dentro" },
      { "<leader>dt", function() require("dap").step_out() end, desc = "Passo fora" },
      { "<leader>dq", function() require("dap").terminate() end, desc = "Encerrar debug" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Alternar painel debug" },
    },
    dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio" },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["yoruvim_ui"] = function() dapui.open() end
      dap.listeners.before.event_terminated["yoruvim_ui"] = function() dapui.close() end
      dap.listeners.before.event_exited["yoruvim_ui"] = function() dapui.close() end

      dap.adapters.gdb = {
        type = "executable", command = "gdb",
        args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
      }
      local native = {
        type = "gdb", request = "launch", name = "Executar binario (GDB)",
        program = function()
          local path = vim.fn.input("Executavel: ", vim.fn.getcwd() .. "/", "file")
          return path ~= "" and path or dap.ABORT
        end,
        cwd = function() return require("yoruvim.utils.project").root() end,
      }
      dap.configurations.c = { native }
      dap.configurations.cpp = { native }
      dap.configurations.rust = { native }

      local adapter = vim.fn.stdpath("data") .. "/dap/js-debug/src/dapDebugServer.js"
      dap.adapters["pwa-node"] = {
        type = "server", host = "127.0.0.1", port = "${port}",
        executable = { command = "node", args = { adapter, "${port}" } },
      }
      local node = {
        {
          type = "pwa-node", request = "launch", name = "Node: arquivo JS (ou TS compilado)",
          program = function()
            local current = vim.fn.expand("%:p")
            if vim.bo.filetype:match("^typescript") then
              local path = vim.fn.input("JavaScript compilado: ", require("yoruvim.utils.project").root() .. "/dist/", "file")
              return path ~= "" and path or dap.ABORT
            end
            return current ~= "" and current or dap.ABORT
          end,
          cwd = function() return require("yoruvim.utils.project").root() end,
          sourceMaps = true, console = "integratedTerminal",
        },
        {
          type = "pwa-node", request = "attach", name = "Node: processo (--inspect)",
          processId = require("dap.utils").pick_process,
          cwd = function() return require("yoruvim.utils.project").root() end,
        },
      }
      dap.configurations.javascript = node
      dap.configurations.javascriptreact = node
      dap.configurations.typescript = node
      dap.configurations.typescriptreact = node
    end,
  },
}
