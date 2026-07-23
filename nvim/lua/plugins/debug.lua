return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",            -- Interface visual (telas flutuantes, variáveis)
      "nvim-neotest/nvim-nio",           -- Dependência obrigatória para renderização assíncrona
      "williamboman/mason.nvim",         -- Integração com o Mason para baixar os adaptadores
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Inicializa a interface de debug com o layout clássico de IDE
      dapui.setup()

      -- Automação: Abre e fecha a interface visual do Debugger automaticamente
      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

      -- Definição dos seus atalhos preferidos usando a barra invertida \
      -- Nota: Usamos letras fáceis de associar com as ações de debug
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Marcar/Desmarcar Breakpoint" })
      vim.keymap.set("n", "<leader>dc", dap.continue,          { desc = "Debug: Iniciar / Continuar Execução" })
      vim.keymap.set("n", "<leader>di", dap.step_into,         { desc = "Debug: Entrar na Função (Step Into)" })
      vim.keymap.set("n", "<leader>do", dap.step_over,         { desc = "Debug: Passar por cima (Step Over)" })
      vim.keymap.set("n", "<leader>dt", dap.terminate,         { desc = "Debug: Encerrar Debugger" })
      
      -- Atalho para abrir/fechar a interface visual manualmente se você precisar
      vim.keymap.set("n", "<leader>du", dapui.toggle,          { desc = "Debug: Alternar Interface Visual" })
    end,
  },
}

