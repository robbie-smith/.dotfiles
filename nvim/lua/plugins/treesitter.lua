return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main", -- the rewrite that supports nvim 0.11+; master is unmaintained for 0.12.
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local langs = {
        "python",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "javascript",
        "typescript",
        "tsx",
        "rust",
        "bash",
        "json",
        "yaml",
        "toml",
        "markdown",
        "markdown_inline",
        "html",
        "css",
      }

      -- Install any missing parsers (async; harmless if already installed).
      require("nvim-treesitter").install(langs)

      -- Start treesitter highlight + indent on file open for supported languages.
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match)
          if not lang then
            return
          end
          if pcall(vim.treesitter.start, args.buf, lang) then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
