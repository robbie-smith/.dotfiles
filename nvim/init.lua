-- Add Lazy.nvim to the runtime path
vim.opt.rtp:prepend("~/.local/share/nvim/lazy/lazy.nvim")

-- Lazy.nvim setup
require("lazy").setup({
    spec = require("plugins.init"),  -- Load plugins from lua/plugins/init.lua
    defaults = {
        lazy = true, -- Lazy-load plugins by default
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "tarPlugin",
                "tohtml",
                "zipPlugin",
                "matchit",
                "matchparen",
                "netrwPlugin", -- Disable netrw if using another file explorer
            },
        },
    },
})

-- Load Neovim configurations

-- Load base settings such as editor options, themes, tab settings, and clipboard integration
require("config.base_setup")
-- Configure Airline, a statusline plugin, for displaying information about the current file and workspace
require("config.airline_settings")
-- Configure FZF (Fuzzy Finder), a fast and extensible fuzzy search plugin for file and text searching
require("config.fzf_settings")
-- Configure GitGutter to display git changes (added, modified, removed lines) in the sign column
require("config.gitgutter_settings")
-- Configure Markdown settings for enhancing Markdown editing and preview capabilities
require("config.markdown_settings")
-- Configure NerdTree, a file explorer plugin, to manage and browse files easily
require("config.nerdtree_settings")
-- Define custom autocommands for automating tasks such as formatting, refreshing, and buffer-specific settings
require("config.auto_commands")
-- Define custom key mappings for streamlined navigation, text manipulation, and plugin-specific shortcuts
require("config.key_mappings")
