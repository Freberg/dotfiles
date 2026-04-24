return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dq", function() require("dap").terminate() end, desc = "DAP: Terminate" },

      { "<leader>du", function() require("dapui").toggle() end, desc = "DAP: Toggle UI" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end

      vim.fn.sign_define('DapBreakpoint', { text='●', texthl='DapBreakpoint', linehl='', numhl='' })
      vim.fn.sign_define('DapStopped', { text='▶', texthl='DapStopped', linehl='Visual', numhl='' })
    end,
  },
}
