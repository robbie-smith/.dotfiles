-- Load Neovim configurations
-- vim.cmd [[packadd packer.nvim]]

-- Start plugin setup
require('config.base_setup')       -- Base settings
require('config.plugins')          -- Plugin management
require('config.plugin_settings')  -- Plugin-specific settings
require('config.auto_commands')    -- Autocommands
require('config.key_mappings')     -- Key mappings
