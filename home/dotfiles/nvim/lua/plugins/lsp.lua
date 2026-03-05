return {
      "neovim/nvim-lspconfig",
      config = function()
            local lspconfig = require("lspconfig")

            lspconfig.clangd.setup({})

            vim.diagnostic.config({
                        virtual_text = true,
                        signs = true,
                        update_in_insert = false,
            })
      end
}
