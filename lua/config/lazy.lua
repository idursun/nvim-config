-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.tabstop = 2
vim.opt.backspace = '2'
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true

vim.opt.incsearch = true
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 100
vim.opt.smarttab = true

vim.keymap.set('n', "<C-f>", "<C-f>zz", { silent = true })
vim.keymap.set('n', "<C-u>", "<C-u>zz", { silent = true })
vim.keymap.set('t', "<C-j>", "<C-\\><C-N>", { silent = true })
vim.keymap.set('t', "<C-j>", "<C-\\><C-N>", { silent = true })
vim.keymap.set('n', '<leader>b', ':b#<CR>')


-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { "tpope/vim-surround" },
    { "windwp/nvim-ts-autotag" },
    -- import your plugins
    { import = "plugins" },
    { import = "plugins.languages.elixir" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "dracula" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
})
