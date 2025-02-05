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
require("config.base_setup")      -- Load base settings (e.g., options, theme, etc.)
require("config.plugin_settings") -- Plugin-specific settings
require("config.markdown")        -- Markdown settings
require("config.auto_commands")   -- Define autocommands
require("config.key_mappings")    -- Define custom key mappings
