return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      if vim.env.SSH_CONNECTION or vim.env.SSH_TTY then
        local user_host = " " .. vim.env.USER .. "@" .. vim.fn.hostname()
        table.insert(opts.sections.lualine_b, 1, function()
          return user_host
        end)
      end
    end,
  },
}
