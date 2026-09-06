return {

  { "rose-pine/neovim", name = "rose-pine", priority = 1000,
  config = function()
    require("rose-pine").setup({
      variant = "moon",    })
    vim.cmd.colorscheme("rose-pine")
  end },

  { "nvim-telescope/telescope.nvim", tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    },
  },

    { "nvim-treesitter/nvim-treesitter", branch = "master", build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "nix", "python", "bash" },
        highlight = { enable = true },      })
    end },
    { "neovim/nvim-lspconfig",
    config = function()
    vim.lsp.enable({ "lua_ls", "pyright", "nil_ls" })
    end },

    { "nvim-tree/nvim-tree.lua",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      keys = { { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" } },
      config = function()
      require("nvim-tree").setup({})
    end },
}

