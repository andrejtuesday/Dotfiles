return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-neotest/nvim-nio", -- required by nvim-dap-ui
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- dap-ui setup with only desired panels
    dapui.setup({
      layouts = {
        {
          elements = {
            "scopes",      -- keep
            "breakpoints", -- keep
            "stacks",      -- keep
            "watches",     -- optional
          },
          size = 40,
          position = "left",
        },
        -- do not define layouts for "repl" or "console"
      },
      floating = {
        max_height = 0.9,
        max_width = 0.5,
        border = "single",
        mappings = { close = { "q", "<Esc>" } },
      },
    })

    require("nvim-dap-virtual-text").setup()

    -- automatically open only defined panels when debugger starts
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- python adapter
    dap.adapters.python = {
      type = "executable",
      command = "python",
      args = { "-m", "debugpy.adapter" },
    }

    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
          return "python"
        end,
      },
    }
  end,
}
