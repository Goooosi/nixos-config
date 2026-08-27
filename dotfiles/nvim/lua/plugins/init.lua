return {
  { "folke/tokyonight.nvim", priority = 1000, config = function()
      vim.cmd.colorscheme("tokyonight")
    end },

  { "nvim-telescope/telescope.nvim", tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    },
  },

  { "nvim-treesitter/nvim-treesitter", branch = "main", build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({ "lua", "nix", "python", "bash" })
    end },

  { "neovim/nvim-lspconfig" },

  { "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = { { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" } },
    config = function()
      require("nvim-tree").setup({})
    end },
}
