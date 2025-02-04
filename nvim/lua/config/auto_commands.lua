-- Auto Commands

-- Automatically resize splits when resizing the window
vim.api.nvim_create_autocmd("VimResized", {
    callback = function()
        vim.cmd("wincmd =")
    end,
})

-- Close NERDTree automatically if it's the last window
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        if vim.fn.winnr("$") == 1 and vim.b.NERDTree and vim.b.NERDTree.isTabTree then
            vim.cmd("q")
        end
    end,
})

-- Automatically delete trailing whitespace and reposition cursor
vim.api.nvim_create_autocmd({"BufWritePre", "InsertLeave"}, {
    callback = function()
        vim.cmd([[%s/\s\+$//e]])
    end,
})

-- Save file on buffer leave if changes were made
vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
        vim.cmd("update")
    end,
})

-- Clear the search register to avoid random highlights
vim.api.nvim_create_autocmd({"VimEnter", "VimLeavePre"}, {
    callback = function()
        vim.cmd("let @/=''")
    end,
})

-- Function to handle journal file type settings
local function set_journal_filetype()
    local dirs = vim.g["journal#dirs"] or {"Dev", "work_notes", "notes", "journal.d"}
    if vim.tbl_contains(dirs, vim.fn.expand("%:p:h:t")) then
        vim.bo.filetype = "journal"
    end
end

-- Assign the journal filetype function to text files
vim.api.nvim_create_autocmd({"BufEnter", "BufRead", "BufNewFile"}, {
    pattern = "*.txt",
    callback = set_journal_filetype,
})
