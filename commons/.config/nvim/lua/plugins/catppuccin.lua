return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha",
            transparent_background = true,
            integrations = {
                telescope = {
                    enabled = true,
                },
                treesitter = true,
                notify = true,
                which_key = true,
            }
        })
        vim.cmd.colorscheme("catppuccin")
    end,
}

