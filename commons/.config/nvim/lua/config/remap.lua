vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { noremap = true })
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })

---------------[ Git ]---------------
vim.keymap.set("n", "<leader>gs", function()
    vim.cmd("80vsplit | term git -c color.status=always status")
end, {desc = "Git status v terminálu"})

vim.keymap.set("n", "<leader>ga", ':!git add .<CR>', {desc = "Git add ."})

vim.keymap.set("n", "<leader>gc", function()
    vim.ui.input({ prompt = 'Commit Message: ' }, function(input)
        if input == nil or input == "" then
            print("Commit cancelled")
            return
        end
        vim.cmd("!git commit -m '" .. input .. "'")
    end)
end, { desc = "Git Commit (Interactive)" })

vim.keymap.set("n", "<leader>gp", ':!git pushCR>', {desc = "Git push"})

vim.keymap.set("n", "<leader>gl", function()
    vim.cmd("vsplit | term git -c color.status=always lg")
end, {desc = "Git lg v terminálu"})

