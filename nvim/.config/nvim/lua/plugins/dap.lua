return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "igorlfs/nvim-dap-view",
      opts = {
        -- Replaces all 4 manual listeners below
        auto_toggle = true,
        winbar = {
          controls = { enabled = true },
        },
        -- Inline variable values next to the current line (requires nvim 0.12+)
        virtual_text = {
          enabled = true,
        },
      },
    },
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = { "mason-org/mason.nvim" },
      opts = {
        ensure_installed = { "python", "js" },
        handlers = {},
      },
    },
  },
  keys = {
    { "<F5>",  function() require("dap").continue() end,          desc = "Debug: Start/Continue" },
    { "<F9>",  function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint" },
    { "<F10>", function() require("dap").step_over() end,         desc = "Debug: Step Over" },
    { "<F11>", function() require("dap").step_into() end,         desc = "Debug: Step Into" },
    { "<F12>", function() require("dap").step_out() end,          desc = "Debug: Step Out" },
    { "<leader>dt", function() require("dap-view").toggle() end,                                        desc = "Debug: Toggle view" },
    { "<leader>dh", function() require("dap-view").hover() end,   mode = { "n", "v" },                  desc = "Debug: Hover variable" },
    { "<leader>dR", function() require("dap").run_last() end,                                           desc = "Debug: Run last" },
    { "<leader>dq", function() require("dap").terminate() end,                                          desc = "Debug: Terminate" },
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end,          desc = "Debug: Conditional breakpoint" },
  },
  config = function()
    local dap = require("dap")

    -- Prevents nvim-dap from jumping into a winfixbuf-protected
    -- window (like dap-view's panels) when stepping/hitting a breakpoint.
    -- See dap-view FAQ: "Why is nvim-dap overriding one of the windows..."
    dap.defaults.fallback.switchbuf = "usevisible,usetab,newtab"

    -- ── Signs ─────────────────────────────────────────────────────────────
    vim.fn.sign_define("DapStopped", {
      text = "▶",
      texthl = "DiagnosticWarn",
      linehl = "debugPC",
      numhl = "DiagnosticWarn",
    })
    vim.fn.sign_define("DapBreakpoint", {
      text = "●",
      texthl = "DiagnosticError",
      numhl = "DiagnosticError",
    })
    vim.fn.sign_define("DapBreakpointCondition", {
      text = "◆",
      texthl = "DiagnosticWarn",
      numhl = "DiagnosticWarn",
    })
    vim.fn.sign_define("DapBreakpointRejected", {
      text = "○",
      texthl = "DiagnosticHint",
      numhl = "DiagnosticHint",
    })
    vim.fn.sign_define("DapLogPoint", {
      text = "◉",
      texthl = "DiagnosticInfo",
      numhl = "DiagnosticInfo",
    })

    -- ── Django ────────────────────────────────────────────────────────────
    -- mason-nvim-dap's default python handler only generates a "Launch file"
    -- config. Django needs to launch manage.py with specific args instead,
    -- so we append a second configuration rather than replace the default.
    dap.configurations.python = dap.configurations.python or {}
    table.insert(dap.configurations.python, {
      type = "python",
      request = "launch",
      name = "Django: runserver",
      -- Auto-discover manage.py: check cwd first, then one level down.
      -- ${workspaceFolder} is a VS Code variable that nvim-dap does NOT expand.
      program = function()
        local cwd = vim.fn.getcwd()
        if vim.fn.filereadable(cwd .. "/manage.py") == 1 then
          return cwd .. "/manage.py"
        end
        -- Search one directory deep (common layout: project/app/manage.py)
        local found = vim.fn.glob(cwd .. "/*/manage.py", false, true)
        if #found > 0 then
          return found[1]
        end
        return vim.fn.input("manage.py path: ", cwd .. "/", "file")
      end,
      -- cwd must point to the directory containing manage.py so Django can
      -- resolve settings and relative imports correctly.
      cwd = function()
        local cwd = vim.fn.getcwd()
        if vim.fn.filereadable(cwd .. "/manage.py") == 1 then
          return cwd
        end
        local found = vim.fn.glob(cwd .. "/*/manage.py", false, true)
        if #found > 0 then
          return vim.fn.fnamemodify(found[1], ":h")
        end
        return cwd
      end,
      args = { "runserver", "--noreload" },
      django = true,
      justMyCode = true,
      console = "integratedTerminal",
      -- Point this at your project's virtualenv python, NOT system python,
      -- or Django (and your other installed packages) won't be importable.
      pythonPath = function()
        return vim.fn.getcwd() .. "/.venv/bin/python"
      end,
    })
  end,
}
