-- Markdown Preview Plugin Configuration
vim.g.mkdp_auto_start = 1 -- Auto start preview when entering Markdown buffer
vim.g.mkdp_auto_close = 1 -- Auto close preview when leaving Markdown buffer
vim.g.mkdp_refresh_slow = 0 -- Auto-refresh preview as you edit or move the cursor
vim.g.mkdp_command_for_global = 0 -- Only allow the command in Markdown files
vim.g.mkdp_open_to_the_world = 0 -- Restrict server to localhost
vim.g.mkdp_open_ip = "" -- Custom IP (empty by default)
vim.g.mkdp_browser = "" -- Specify custom browser to open preview
vim.g.mkdp_echo_preview_url = 0 -- Don't echo preview URL in command line
vim.g.mkdp_browserfunc = "" -- Custom function for opening the preview

-- Markdown rendering options
vim.g.mkdp_preview_options = {
    mkit = {}, -- Options for markdown-it
    katex = {}, -- Options for KaTeX
    uml = {}, -- Options for PlantUML
    maid = {}, -- Options for Mermaid
    disable_sync_scroll = 0, -- Enable sync scrolling
    sync_scroll_type = "middle", -- Cursor position always at the middle
    hide_yaml_meta = 1, -- Hide YAML metadata
    sequence_diagrams = {}, -- Options for sequence diagrams
    flowchart_diagrams = {}, -- Options for flowcharts
    content_editable = false, -- Disable content editing
    disable_filename = 0, -- Show filename header
    toc = {}, -- Options for table of contents
}

vim.g.mkdp_markdown_css = "" -- Custom Markdown style (absolute path)
vim.g.mkdp_highlight_css = "" -- Custom highlight style (absolute path)
vim.g.mkdp_port = "" -- Custom port (leave empty for random)
vim.g.mkdp_page_title = "「${name}」" -- Title for preview page
vim.g.mkdp_images_path = "/home/user/.markdown_images" -- Custom image location
vim.g.mkdp_filetypes = { "markdown" } -- Recognized filetypes for MarkdownPreview
vim.g.mkdp_theme = "dark" -- Default theme for preview (dark or light)
vim.g.mkdp_combine_preview = 0 -- Don't reuse preview window
vim.g.mkdp_combine_preview_auto_refresh = 1 -- Auto refresh for combined preview
