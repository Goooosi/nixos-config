local opt = vim.opt


opt.number = true
opt.relativenumber = true
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true
opt.ignorecase = true
opt.smartcase = true
opt.wrap = false
opt.termguicolors = true
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.updatetime = 250
vim.cmd([[colorscheme umbreon]])

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    if vim.v.event.operator == "y" then
      vim.fn.setreg("+", vim.fn.getreg('"'))
    end
  end,
})

