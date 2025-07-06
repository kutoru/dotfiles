local get_curr_file_path = function()
  local curr_path = vim.fn.expand("%")
  local first_char = string.sub(curr_path, 1, 1)

  if first_char == "~" or first_char == "/" or first_char == "." then
    return curr_path
  else
    return "./" .. curr_path
  end
end

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup({
      default = {
        create_list_item = function(_, item)
          return item
        end,
        display = function(item)
          return item
        end,
        equals = function(item_a, item_b)
          return item_a == item_b
        end,
        select = function(item)
          if item ~= get_curr_file_path() then
            vim.cmd("e " .. item)
          end
        end,
      },
    })

    local map = vim.keymap.set

    map("n", "<leader>a", function()
      harpoon:list():add(get_curr_file_path())
    end)
    map("n", "<leader>e", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)
    map("n", "<leader>cc", function()
      harpoon:list():clear()
    end)

    map("n", "<C-h>", function()
      harpoon:list():select(1)
    end)
    map("n", "<C-j>", function()
      harpoon:list():select(2)
    end)
    map("n", "<C-k>", function()
      harpoon:list():select(3)
    end)
    map("n", "<C-l>", function()
      harpoon:list():select(4)
    end)

    map("n", "<leader>p", function()
      harpoon:list():prev()
    end)
    map("n", "<leader>n", function()
      harpoon:list():next()
    end)
  end,
}
