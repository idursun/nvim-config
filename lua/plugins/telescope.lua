return {
  "nvim-telescope/telescope.nvim",
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  enabled = false,
  config = function()
    require("telescope").setup({
      defaults = {
        file_ignore_patterns = {
          "node_modules",
          "_build",
          "deps"
        },
      },
    })
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    vim.keymap.set('n', '<leader>s', builtin.lsp_document_symbols, {})
    vim.keymap.set('n', '<leader>fr', builtin.buffers, {})
  end,
}
