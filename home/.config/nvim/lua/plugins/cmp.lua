return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    -- "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
  },
  config = function()
    local cmp = require("cmp")

    local enabled = function()
      return true
    end

    local mapping = cmp.mapping.preset.insert({
      ["<C-y>"] = cmp.mapping.scroll_docs(-4),
      ["<C-e>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      -- ["<C-s>"] = cmp.mapping.close(),
      ["<TAB>"] = cmp.mapping.confirm({ select = true }),
    })

    local snippet = {
      expand = function(args) end,
    }

    local sources = cmp.config.sources({
      { name = "nvim_lsp" },
      -- { name = "buffer" },
      { name = "path" },
    })

    cmp.setup({
      enabled = enabled,
      mapping = mapping,
      snippet = snippet,
      sources = sources,
      window = {
        completion = {
          scrolloff = 2,
        },
      },
    })

    vim.cmd([[
      set completeopt=menuone,noinsert,noselect
      highlight! default link CmpItemKind CmpItemMenuDefault
    ]])
  end,
}
