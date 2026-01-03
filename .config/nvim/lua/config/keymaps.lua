-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

if vim.g.neovide then
  vim.keymap.set("n", "<X1Mouse>", "<C-O>", { desc = "Go back in jump list" })
  vim.keymap.set("n", "<X2Mouse>", "<C-I>", { desc = "Go forward in jump list" })
end
