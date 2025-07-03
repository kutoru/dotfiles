return {
  "echasnovski/mini.nvim",
  version = "*",
  config = function()
    require("mini.ai").setup()
    require("mini.surround").setup({
      mappings = {
        add = "<leader>s",
        delete = "ds",
        replace = "cs",

        find = "",
        find_left = "",
        highlight = "",
        update_n_lines = "",
        suffix_last = "",
        suffix_next = "",
      },

      n_lines = 50,
    })
  end,
}
