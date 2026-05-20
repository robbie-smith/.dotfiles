return {
  {
    "supermaven-inc/supermaven-nvim",
    event = "InsertEnter",
    opts = {
      keymaps = {
        accept_suggestion = "<Tab>",
        clear_suggestion = "<C-]>",
        accept_word = "<C-j>", -- accept just the next word of the ghost text
      },
      -- Don't fight with FZF/other prompts
      ignore_filetypes = { "TelescopePrompt", "snacks_input", "fzf" },
      disable_inline_completion = false,
      disable_keymaps = false,
    },
  },
}
