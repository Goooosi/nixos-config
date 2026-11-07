return {
  -- Native LSP Hook Management Layer
  {
    "hrsh7th/cmp-nvim-lsp",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      -- Hook up shortcuts on LSP attach
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        end,
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("ts_ls", { capabilities = capabilities })
      vim.lsp.enable("ts_ls")

      -- Configured Pyright with Dynamic Cross-Platform Path Detection
      vim.lsp.config("pyright", {
        capabilities = capabilities,
        on_init = function(client)
          local cwd = vim.fn.getcwd()
          local python_path = ""

          -- 1. Check for standard local virtual environments (Windows vs Unix)
          if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
            local win_venv = cwd .. "\\.venv\\Scripts\\python.exe"
            if vim.fn.executable(win_venv) == 1 then
              python_path = win_venv
            end
          else
            local unix_venv = cwd .. "/.venv/bin/python"
            if vim.fn.executable(unix_venv) == 1 then
              python_path = unix_venv
            end
          end

          -- 2. Fallback: Lookup the active shell path (Nix DevShell / Global Environment)
          if python_path == "" then
            local shell_python = vim.fn.exepath("python")
            if shell_python ~= "" then
              python_path = shell_python
            end
          end

          -- 3. Bind interpreter settings to the Pyright instance
          if python_path ~= "" then
            client.config.settings.python.pythonPath = python_path
            client:notify("workspace/didChangeConfiguration", { settings = client.config.settings })
          end
        end,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
      })
      vim.lsp.enable("pyright")

      vim.lsp.config("nil_ls", { capabilities = capabilities })
      vim.lsp.enable("nil_ls")

      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = { Lua = { diagnostics = { globals = { "vim" } } } },
      })
      vim.lsp.enable("lua_ls")
    end,
  },
}

