return {
  -- Native LSP Hook Management Layer
  {
    "hrsh7th/cmp-nvim-lsp",
    config = function()
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

      -- Target language setups
      vim.lsp.config("ts_ls", { cmd = { "typescript-language-server", "--stdio" }, capabilities = capabilities })
      vim.lsp.enable("ts_ls")

      vim.lsp.config("pyright", { capabilities = capabilities })
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

