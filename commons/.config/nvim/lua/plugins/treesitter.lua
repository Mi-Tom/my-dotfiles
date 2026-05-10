return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main", 
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    
    opts = {
        ensure_installed = {
            "bash",
            "c",
            "json",
            "lua",
            "markdown",
            "markdown_inline",
            "toml",
            

            "html",
            "css",
            "javascript",
            "typescript",
        },
        
        auto_install = true,
        
        highlight = { 
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        
        indent = { enable = true },
    },
    
    config = function(_, opts)
        local ts = require("nvim-treesitter")
        
        setmetatable(require("nvim-treesitter.install"), {
            __newindex = function(_, k)
                if k == "compilers" then
                    vim.schedule(function()
                        vim.notify("Setting custom compilers for `nvim-treesitter` is no longer supported.", vim.log.levels.WARN)
                    end)
                end
            end,
        })

        ts.setup(opts)
    end,
}
