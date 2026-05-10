return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { 
            "nvim-telescope/telescope-fzf-native.nvim", 
            build = "make"
        },
    },
    config = function()
        local telescope = require("telescope")
        
        telescope.setup({
            defaults = {
                file_ignore_patterns = { "%.git/" }   
            },
            pickers = {
                find_files = {
                    hidden = true,
                },
                live_grep = {
                    hidden = true,
                },
            },
        })
        
        telescope.load_extension("fzf")

        local builtin = require("telescope.builtin")
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    end,
}
