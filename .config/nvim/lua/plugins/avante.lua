if true then
  return {}
end

return {
  {
    "yetone/avante.nvim",
    opts = {
      provider = "opencode",
      acp_providers = {
        ["opencode"] = {
          command = "opencode-cli",
          args = { "acp" },
          -- env = {
          --   OPENCODE_API_KEY = os.getenv("OPENCODE_API_KEY"),
          -- },
        },
      },
    },
  },
}
