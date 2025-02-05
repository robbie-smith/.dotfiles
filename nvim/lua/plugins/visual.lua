return {
  { "scrooloose/nerdtree", cmd = "NERDTreeToggle", lazy = false }, -- File explorer
{
    "vim-airline/vim-airline",
    event = "BufRead", -- Load airline when reading a buffer
  },

  -- Airline themes plugin
  {
    "vim-airline/vim-airline-themes",
    lazy = false, -- Ensure themes are available when airline loads
    config = function()
      vim.g.airline_theme = "onedark" -- Set your preferred theme here
    end,
  },
}
