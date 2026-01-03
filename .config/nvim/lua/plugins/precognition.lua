return {
  {
    "chrisgrieser/nvim-spider",
    keys = {
      { "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
      { "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
      { "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
    },
    opts = {}, -- calls `setup()`, which registers the precognition adapter
  },
  {
    "tris203/precognition.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>uP",
        function()
          require("precognition").toggle()
        end,
        desc = "Precognition Toggle",
      },
    },
    opts = {
      startVisible = false,
      -- showBlankVirtLine = true,
      -- highlightColor = { link = "Comment" },
      -- hints = {
      --   Caret = { text = "^", prio = 2 },
      --   Dollar = { text = "$", prio = 1 },
      --   MatchingPair = { text = "%", prio = 5 },
      --   Zero = { text = "0", prio = 1 },
      --   w = { text = "w", prio = 10 },
      --   b = { text = "b", prio = 9 },
      --   e = { text = "e", prio = 8 },
      --   W = { text = "W", prio = 7 },
      --   B = { text = "B", prio = 6 },
      --   E = { text = "E", prio = 5 },
      -- },
      -- gutterHints = {
      --     G = { text = "G", prio = 10 },
      --     gg = { text = "gg", prio = 9 },
      --     PrevParagraph = { text = "{", prio = 8 },
      --     NextParagraph = { text = "}", prio = 8 },
      -- },
      -- disabled_fts = {
      --     "startify",
      -- },
    },
    --   config = function(_, opts)
    --     require("precognition").configure(opts)
    --
    --     Snacks.toggle({
    --       name = "Precognition",
    --       get = function()
    --         local m = require("precognition")
    --         local state = m.toggle()
    --         m.toggle()
    --         return not state
    --       end,
    --       set = function(enabled)
    --         local m = require("precognition")
    --         local state = m.toggle()
    --         m.toggle()
    --         if enabled and not state then
    --           m.toggle()
    --         end
    --       end,
    --     }):map("<leader>uP")
    --   end,
    --
  },
}
