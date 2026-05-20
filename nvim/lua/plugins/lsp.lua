return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Build default capabilities (with cmp completion advertised if cmp-nvim-lsp is available).
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok_cmp then
        capabilities = vim.tbl_deep_extend("force", capabilities, cmp_lsp.default_capabilities())
      end

      -- Defaults applied to every server.
      vim.lsp.config("*", { capabilities = capabilities })

      -- Per-server overrides. mason-lspconfig v2 `automatic_enable` will read these
      -- when it calls vim.lsp.enable() for each installed server.
      vim.lsp.config("pyright", {
        settings = {
          pyright = {
            disableOrganizeImports = true, -- ruff handles imports
          },
        },
      })
      vim.lsp.config("ruff", {
        on_attach = function(client, _)
          -- defer hover to pyright so we don't get two hovers
          client.server_capabilities.hoverProvider = false
        end,
      })

      require("mason").setup()

      require("mason-tool-installer").setup({
        ensure_installed = {
          "typescript-language-server",
          "pyright",
          "ruff",
          "rust-analyzer",
          "prettier",
          "eslint_d",
        },
      })

      require("mason-lspconfig").setup({
        ensure_installed = { "ts_ls", "pyright", "ruff", "rust_analyzer" },
        automatic_enable = true,
      })

      -- LSP keybindings, set when an LSP attaches to a buffer.
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach-keybinds", { clear = true }),
        callback = function(e)
          local keymap = function(keys, func)
            vim.keymap.set("n", keys, func, { buffer = e.buf })
          end

          keymap("gd", vim.lsp.buf.definition)
          keymap("gD", vim.lsp.buf.declaration)
          keymap("gr", vim.lsp.buf.references)
          keymap("<leader>fu", function()
            -- "find usages" — references + auto-open the quickfix list
            vim.lsp.buf.references()
            vim.defer_fn(function()
              vim.cmd("copen")
            end, 200)
          end)
          keymap("gI", vim.lsp.buf.implementation)
          keymap("<leader>D", vim.lsp.buf.type_definition)
          keymap("<leader>ds", vim.lsp.buf.document_symbol)
          keymap("<leader>ws", vim.lsp.buf.workspace_symbol)
          keymap("<leader>rn", vim.lsp.buf.rename)
          keymap("<leader>ca", vim.lsp.buf.code_action)
          keymap("K", vim.lsp.buf.hover)
        end,
      })
    end,
  },
}
