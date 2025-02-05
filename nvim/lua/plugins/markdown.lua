return {
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install", -- Run npm install in the app directory
        ft = { "markdown" }, -- Load only for Markdown files
    },
}
