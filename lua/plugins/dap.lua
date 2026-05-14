-- Debug Adapter Protocol (DAP) configuration
-- Common DAP UI, keymaps, and signs

return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      -- Breakpoint signs
      vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticWarn" })
      vim.fn.sign_define(
        "DapStopped",
        { text = "", texthl = "DiagnosticInfo", linehl = "Visual" }
      )
      vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticInfo" })
    end,
    keys = {
      {
        "<F5>",
        function() require("dap").continue() end,
        desc = "DAP Continue",
      },
      {
        "<F10>",
        function() require("dap").step_over() end,
        desc = "DAP Step Over",
      },
      {
        "<F11>",
        function() require("dap").step_into() end,
        desc = "DAP Step Into",
      },
      {
        "<F12>",
        function() require("dap").step_out() end,
        desc = "DAP Step Out",
      },
      {
        "<Leader>db",
        function() require("dap").toggle_breakpoint() end,
        desc = "Toggle Breakpoint",
      },
      {
        "<Leader>dB",
        function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
        desc = "Conditional Breakpoint",
      },
      {
        "<Leader>dr",
        function() require("dap").repl.open() end,
        desc = "Open REPL",
      },
      {
        "<Leader>dl",
        function() require("dap").run_last() end,
        desc = "Run Last",
      },
      {
        "<Leader>dt",
        function() require("dap").terminate() end,
        desc = "Terminate",
      },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    keys = {
      {
        "<Leader>du",
        function() require("dapui").toggle() end,
        desc = "Toggle DAP UI",
      },
      {
        "<Leader>de",
        function() require("dapui").eval() end,
        mode = { "n", "v" },
        desc = "Evaluate Expression",
      },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap" },
    opts = {},
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "mfussenegger/nvim-dap" },
    cmd = { "DapInstall", "DapUninstall" },
    opts = {
      automatic_installation = true,
      ensure_installed = {
        "js-debug-adapter",
        "delve",
        "debugpy",
        "netcoredbg",
      },
    },
  },
}
