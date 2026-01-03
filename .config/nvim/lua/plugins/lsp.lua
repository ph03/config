return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- ❌ disable Pyright
        pyright = false,

        -- ✅ type checking
        ty = {},

        -- ✅ linting & code actions
        ruff = {
          -- init_options = {
          --   settings = {
          --     -- let ruff handle linting only
          --     -- organizeImports = true,
          --   },
          -- },
        },
      },
      inlay_hints = { enabled = false },
    },
  },
}
