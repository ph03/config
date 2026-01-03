return {
  {
    "rcarriga/nvim-dap-ui",
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      -- don't close on terminate / exit
      --dap.listeners.before.event_terminated["dapui_config"] = function()
      --  dapui.close({})
      --end
      --dap.listeners.before.event_exited["dapui_config"] = function()
      --  dapui.close({})
      --end
    end,
    -- keys = {
    --   {
    --     "<leader>d<space>",
    --     function()
    --       require("which-key").show({ keys = "<leader>d", loop = true })
    --     end,
    --     desc = "Debug Hydra Mode (which-key)",
    --   },
    -- },
  },
}
