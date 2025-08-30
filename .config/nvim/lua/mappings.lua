require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

vim.api.nvim_set_keymap('n', '<F5>', ':w<CR>:!python3 %<CR>', { noremap = true, silent = true })



vim.api.nvim_create_autocmd("FileType", {
  pattern = "NvimTree",
  callback = function()
    local api = require("nvim-tree.api")

    -- smarter "h"
    vim.keymap.set("n", "h", function()
      local node = api.tree.get_node_under_cursor()
      if node and node.type == "directory" and node.open then
        -- collapse this folder
        api.node.open.edit()
      else
        -- go up one directory
        api.tree.change_root_to_parent()
      end
    end, { buffer = true, desc = "Collapse folder or go up directory" })

    -- "l" expand/open only, never collapse
    vim.keymap.set("n", "l", function()
      local node = api.tree.get_node_under_cursor()
      if node then
        if node.type == "directory" and not node.open then
          -- expand only if closed
          api.node.open.edit()
        elseif node.type ~= "directory" then
          -- always open files
          api.node.open.edit()
        end
      end
    end, { buffer = true, desc = "Expand dir / open file" })
  end,
})

