return {
    'numToStr/Comment.nvim',
    config = function()
      require("Comment").setup()

      vim.keymap.set({ "n", "v" }, "<C-/>", ":norm gcc<CR>", { silent = true })
      -- vim.keymap.set("v", "<C-/>", ":norm gcc<CR>gv", { silent = true })
    end,
}
