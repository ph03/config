return {
  -- {
  --   "elliotxx/copypath.nvim",
  --   config = function()
  --     require("copypath").setup({
  --       -- Your custom config here
  --       -- Default options
  --       default_mappings = true, -- Set to false to disable default mappings
  --       mapping = "Y", -- Default mapping to trigger copy
  --       notify = true, -- Show notification when path is copied
  --     })
  --   end,
  -- },
  {
    "zhisme/copy_with_context.nvim",
    config = function()
      require("copy_with_context").setup({
        -- Customize mappings
        mappings = {
          relative = "<leader>ycr",
          absolute = "<leader>yca",
          remote = "<leader>ycu",
        },
        formats = {
          default = "# {filepath}:{line}", -- Used by relative and absolute mappings
          remote = "# {remote_url}",
        },
        -- whether to trim lines or not
        trim_lines = false,
      })
    end,
  },
  {
    "cajames/copy-reference.nvim",
    opts = {
      register = "+",
      use_git_root = true,
    },
    keys = {
      { "<leader>y", group = "Copy Reference" },
      { "<leader>yf", "<cmd>CopyReference file<cr>", mode = { "n", "v" }, desc = "Copy file path" },
      { "<leader>yy", "<cmd>CopyReference line<cr>", mode = { "n", "v" }, desc = "Copy file:line reference" },
    },
  },
}
