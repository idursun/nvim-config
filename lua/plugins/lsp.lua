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

      local lspconfig = require('lspconfig')
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      local configs = require("lspconfig.configs")

      if not configs.lexical then
        local lexical_config = {
          filetypes = { "elixir", "eelixir", "heex" },
          cmd = { "/Users/idursun/repositories/elixir/lexical/_build/dev/package/lexical/bin/start_lexical.sh" },
          settings = {},
        }
        configs.lexical = {
          default_config = {
            filetypes = lexical_config.filetypes,
            cmd = lexical_config.cmd,
            root_dir = function(fname)
              return lspconfig.util.root_pattern("mix.exs", ".git")(fname) or vim.loop.os_homedir()
            end,
            -- optional settings
            settings = lexical_config.settings,
          },
        }
      end

      lspconfig.lexical.setup({})
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            hint = { enable = true, },
          }
        }
      })
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        settings = {
          typescript = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = false,
            }
          }
        }
      })
      lspconfig.rust_analyzer.setup({})
      lspconfig.zls.setup({})
      lspconfig.gopls.setup({})
      lspconfig.yamlls.setup({})

      lspconfig.tailwindcss.setup({
        init_options = {
          userLanguages = {
            elixir = "html-eex",
            eelixir = "html-eex",
            heex = "html-eex",
          }
        },
        root_dir = lspconfig.util.root_pattern("assets", "tailwind.config.js", ".git"),
      })

      lspconfig.emmet_ls.setup({
        capabilities = capabilities,
        filetypes = { "html", "heex", "eex" }
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
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
        end,
      })
    end,
  },
  "rafamadriz/friendly-snippets",
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "l3mon4d3/luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ['<M-k>'] = cmp.mapping.scroll_docs(-4),
          ['<M-j>'] = cmp.mapping.scroll_docs(4),
          ['<C-o>'] = cmp.mapping.complete(),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
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
