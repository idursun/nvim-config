return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "<leader>ff",
      function()
        require("fzf-lua").files({ cmd = "rg --files" })
      end,
      desc = "Find files",
    },
    {
      "<leader>fg",
      function()
        require("fzf-lua").grep_project()
      end,
      desc = "Grep project",
    },
    {
      "<leader>fr",
      function()
        require("fzf-lua").buffers()
      end,
      desc = "List buffers",
    },
    {
      "<leader>s",
      function()
        require("fzf-lua").lsp_document_symbols()
      end,
      desc = "List document symbols",
    },
  },
  config = function()
    -- calling `setup` is optional for customization
    require("fzf-lua").setup({
      files = {
        cwd_prompt = false,
      },
      file_ignore_patterns = { "^deps/", "^_build/", "^.*/node_modules/" },
    })
  end,
}
