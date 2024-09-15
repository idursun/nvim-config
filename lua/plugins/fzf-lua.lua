return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- calling `setup` is optional for customization
    require("fzf-lua").setup({
      files = {
        cwd_prompt = false,
      },
      file_ignore_patterns = { "^deps/", "^_build/", "^.*/node_modules/" },
    })
    local actions = require('fzf-lua')
    vim.keymap.set('n', '<leader>ff', function() actions.files({ cmd = "rg --files" }) end, {})
    vim.keymap.set('n', '<leader>fg', actions.grep_project, {})
    vim.keymap.set('n', '<leader>fr', actions.buffers, {})
    vim.keymap.set('n', '<leader>s', actions.lsp_document_symbols, {})
  end,
}
