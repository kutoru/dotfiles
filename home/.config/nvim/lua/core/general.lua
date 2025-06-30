-- numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- indentation hell
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smarttab = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.expandtab = true

-- scrolloff
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 16

-- misc
vim.opt.encoding = "UTF-8"
vim.opt.mouse = "a"
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.termguicolors = true
vim.opt.wrap = false

-- copy to system clipboard
vim.opt.clipboard = "unnamedplus"

-- disable auto comments
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- disable diagnostic signs
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
  },
})

-- remove tildes at eof
-- vim.opt.fillchars = { eob = " " }

-- search
vim.opt.smartcase = true
vim.opt.hlsearch = false

vim.cmd([[
  augroup vimrc-incsearch-highlight
    autocmd!
    autocmd CmdlineEnter /,\? :set hlsearch
    autocmd CmdlineLeave /,\? :set nohlsearch
  augroup END
]])
