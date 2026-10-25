return {
  { 
    "nvim-telescope/telescope.nvim", 
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    },
  },
  { 
    "nvim-treesitter/nvim-treesitter", 
    branch = "master", 
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "nix", "python", "bash", "typescript", "tsx" },
        highlight = { enable = true },
      })
    end 
  },
}

