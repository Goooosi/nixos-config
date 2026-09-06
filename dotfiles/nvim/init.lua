local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("config.options")
require("config.keymaps")
require("lazy").setup("plugins")

-- Force unnamedplus to re-apply immediately after Neovim finishes initializing
vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Force system clipboard synchronization",
  callback = function()
    vim.opt.clipboard = "unnamedplus"
  end,
})
-- Explicitly force the standard yank keys to use the OS clipboard register
vim.keymap.set({"n", "v"}, "y", '"+y', { desc = "Force yank to system clipboard", remap = false })
vim.keymap.set("n", "yy", '"+yy', { desc = "Force yank line to system clipboard", remap = false })
vim.keymap.set({"n", "v"}, "Y", '"+Y', { desc = "Force yank to end of line", remap = false })

-- Keep ONLY this line for the clipboard
vim.opt.clipboard = "unnamedplus"

