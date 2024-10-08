return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "williamboman/mason.nvim",
        config = function()
          require("mason").setup({})
        end,
      },
      {
        "williamboman/mason-lspconfig.nvim",
        config = function()
          require('mason-lspconfig').setup({
            ensure_installed = { "lua_ls", "rust_analyzer", "zls", "gopls", "yamlls", "emmet_ls", "tailwindcss", "ts_ls" }
          })
        end,
      },
    },
    opts = {
      inlay_hints = {
        enabled = true,
      }
    },
    config = function()
      require('mason').setup({})
      local lsp_config = require('lspconfig')
      local mason_lspconfig = require('mason-lspconfig')
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local servers = mason_lspconfig.get_installed_servers()
      for _, server in ipairs(servers) do
        local opts = {
          capabilities = capabilities,
        }
        local has_custom_opts, custom_opts = pcall(require, "plugins.languages." .. server)
        if has_custom_opts then
          opts = vim.tbl_deep_extend("force", opts, custom_opts)
        end
        if lsp_config[server] then
          lsp_config[server].setup(opts)
        end
      end

      require('plugins.languages.elixir_lexical')

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.ls.omnifunc'

          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'v', 'n' }, '<leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '<leader>L', function()
            vim.lsp.buf.format { async = true }
          end, opts)
          vim.keymap.set('n', '<leader>e', function()
            vim.diagnostic.open_float(nil, { focusable = true })
          end, opts)
          vim.keymap.set('n', '<leader>dd', '<cmd>FzfLua diagnostics_workspace<CR>', { noremap = true, silent = true })
          vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { noremap = true, silent = true })
          vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { noremap = true, silent = true })
          vim.keymap.set("n", '<leader>i',
            function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 }) end,
            {})

          if client.supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = ev.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, async = false })
              end,
            })
          end
        end,
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "l3mon4d3/luasnip",
        dependencies = {
          "rafamadriz/friendly-snippets",
        },
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
    },
    config = function()
      local luasnip = require('luasnip')
      local cmp = require('cmp')
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ['<M-k>'] = cmp.mapping.scroll_docs(-4),
          ['<M-j>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
        }),
      })
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function()
      require('lsp_signature').setup({
        floating_window = false,
      })
    end,
  },
}
