local map = vim.keymap.set

-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- reload nvim config
map("n", "<Leader>r", ":source %<CR>")

-- center screen on C-d and C-u
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- deleting whole words
map("i", "<C-Delete>", "<C-o>dw")
map("i", "<C-Backspace>", "<C-w>")

-- move lines up and down
map("n", "<M-j>", ":m .+1<CR>==", { silent = true })
map("n", "<M-k>", ":m .-2<CR>==", { silent = true })
map("v", "<M-j>", ":m '>+1<CR>gv=gv", { silent = true })
map("v", "<M-k>", ":m '<-2<CR>gv=gv", { silent = true })

-- after entering insert mode from visual block,
-- to apply changes to all selected lines
-- apparently you must specifically hit <ESC>
map("i", "<C-c>", "<ESC>")

-- delete and paste without copying
map("v", "<leader>d", "\"_d")
map("v", "<leader>p", "\"_dp")

-- insert a new line without entering insert mode
map("n", "<M-o>", "mto<ESC>`t")
map("n", "<M-S-o>", "mtO<ESC>`t")

-- split line into two to the left of the cursor
map("n", "<S-k>", "hmta<CR><ESC>V=`t")

-- insert space without entering insert mode
map("n", "<M-i>", "i<Space><ESC>l")
map("n", "<M-a>", "a<Space><ESC>h")

-- common shortcuts
map("n", "<Leader>q", ":q<CR>")
map("n", "<Leader>w", ":w<CR>")

-- toggle line wrapping
local function toggle_line_wrap()
  if vim.o.wrap then
    print("Line wrapping is off")
  else
    print("Line wrapping is on")
  end
  return ":set wrap!<Enter>"
end

map("n", "<M-x>", toggle_line_wrap, { silent = true, expr = true })
