return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        texlab = {
          on_attach = function(client, bufnr)
            -- Texlab soll KEINE Formatierung mehr anbieten
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end,
        },
      },
    },
  },
}
