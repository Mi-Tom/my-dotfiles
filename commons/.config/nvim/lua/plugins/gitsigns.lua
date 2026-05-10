return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" }, 
    opts = {
    signs = {
        add          = { text = '+' },
        change       = { text = '┃' },
        delete       = { text = '-' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
    },
    signcolumn = true,  
    current_line_blame = true, 
    current_line_blame_opts = {
        delay = 250, 
    },
    
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
        end

        map('n', ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
        end, {expr=true, desc = "Další Git změna"})

        map('n', '[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
        end, {expr=true, desc = "Předchozí Git změna"})

        map('n', '<leader>hs', gs.stage_hunk, { desc = "Stage změny" })
        map('n', '<leader>hr', gs.reset_hunk, { desc = "Reset změny" })
        map('n', '<leader>hp', gs.preview_hunk, { desc = "Náhled změny (v okně)" })
        map('n', '<leader>hb', function() gs.blame_line{full=true} end, { desc = "Kompletní Git Blame" })
    end
    },
}
