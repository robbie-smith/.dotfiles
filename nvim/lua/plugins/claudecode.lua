return {
  {
    "coder/claudecode.nvim",
    cmd = {
      "ClaudeCode",
      "ClaudeCodeFocus",
      "ClaudeCodeSend",
      "ClaudeCodeAdd",
      "ClaudeCodeDiffAccept",
      "ClaudeCodeDiffDeny",
    },
    config = true,
    keys = {
      { "<leader>cc", "<cmd>ClaudeCode<cr>",          desc = "Toggle Claude Code" },
      { "<leader>cf", "<cmd>ClaudeCodeFocus<cr>",     desc = "Focus Claude window" },
      { "<leader>cr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude session" },
      { "<leader>cC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue last Claude session" },
      { "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>",     desc = "Add current buffer to Claude" },
      { "<leader>cs", "<cmd>ClaudeCodeSend<cr>",      mode = "v", desc = "Send selection to Claude" },
      -- Diff review keys (avoid <leader>ca which is already LSP code-action)
      { "<leader>cy", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Claude diff (yes)" },
      { "<leader>cn", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Reject Claude diff (no)" },
    },
  },
}
