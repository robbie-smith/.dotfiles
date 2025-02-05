return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim", -- Mason for managing LSP servers, DAP, etc.
      "williamboman/mason-lspconfig.nvim", -- Integrates Mason with LSP
      "WhoIsSethDaniel/mason-tool-installer.nvim", -- Tool installer
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local mason_tool_installer = require("mason-tool-installer")

      local default_capabilities = vim.lsp.protocol.make_client_capabilities()

      -- Define LSP server configurations
      local server_configs = {
        tsserver = {}, -- TypeScript/JavaScript
        pyright = {}, -- Python
        rust_analyzer = {}, -- Rust
      }

      mason.setup() -- Setup Mason

      -- Collect all servers to ensure installation with Mason
      local mason_ensure_installed = {
        "typescript-language-server",
        "pyright",
        "rust-analyzer",
        "prettier", -- Formatter
        "eslint_d", -- Linter
      }
      mason_tool_installer.setup({
        ensure_installed = mason_ensure_installed, -- Auto-install servers/tools
      })

      -- Setup Mason-LSPConfig and attach server configurations
      mason_lspconfig.setup({
        handlers = {
          function(server_name)
            local server_config = server_configs[server_name] or {}
            server_config.capabilities = vim.tbl_deep_extend(
              "force",
              default_capabilities,
              server_config.capabilities or {}
            )
            lspconfig[server_name].setup(server_config)
          end,
        },
      })

      -- Create key mappings when an LSP attaches to a buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach-keybinds", { clear = true }),
        callback = function(e)
          local keymap = function(keys, func)
            vim.keymap.set("n", keys, func, { buffer = e.buf })
          end
          local builtin = require("telescope.builtin")

          -- Keybindings
          keymap("gd", builtin.lsp_definitions)
          keymap("gD", vim.lsp.buf.declaration)
          keymap("gr", builtin.lsp_references)
          keymap("gI", builtin.lsp_implementations)
          keymap("<leader>D", builtin.lsp_type_definitions)
          keymap("<leader>ds", builtin.lsp_document_symbols)
          keymap("<leader>ws", builtin.lsp_dynamic_workspace_symbols)
          keymap("<leader>rn", vim.lsp.buf.rename)
          keymap("<leader>ca", vim.lsp.buf.code_action)
          keymap("K", vim.lsp.buf.hover)
        end,
      })
    end,
  },
}
