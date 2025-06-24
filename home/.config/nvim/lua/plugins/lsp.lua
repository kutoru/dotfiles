local mason_setup = function(ensure_installed)
  require("mason").setup()

  require("mason-lspconfig").setup({
    automatic_installation = true,
    ensure_installed = ensure_installed,
  })

  require("mason-tool-installer").setup({
    ensure_installed = {
      "prettier",
      "stylua",
      "eslint_d",
    },
  })
end

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local servers = {
      ts_ls = {},
      lua_ls = {
        Lua = {
          telemetry = { enable = false },
          workspace = { checkThirdParty = false },
        },
      },
    }

    mason_setup(vim.tbl_keys(servers))

    local on_attach = function(client, bufnr)
      -- format on save

      if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = vim.api.nvim_create_augroup("Format", { clear = true }),
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format()
          end,
        })
      end

      -- maps

      local map = vim.keymap.set

      map("n", "<F2>", vim.lsp.buf.rename)
      map("n", "<leader>ca", vim.lsp.buf.code_action)
      map("n", "gd", vim.lsp.buf.definition)
      map("n", "gi", vim.lsp.buf.implementation)
      map("n", "gh", vim.lsp.buf.hover)
    end

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    vim.lsp.config("*", {
      on_attach = on_attach,
      capabilities = capabilities,
    })

    for server, _ in pairs(servers) do
      vim.lsp.config[server] = {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = servers[server],
      }
    end
  end,
}
