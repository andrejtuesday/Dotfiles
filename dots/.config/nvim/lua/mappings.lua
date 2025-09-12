require "nvchad.mappings"

local map = vim.keymap.set

map("i", "jk", "<ESC>")

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


local dap = require("dap")

vim.keymap.set("n", "<F9>", function()
  if dap.session() then
    dap.restart()
  else
    dap.continue()
  end
end, { desc = "Restart or start debugger" })

vim.keymap.set("n", "<F6>", function() dap.continue() end)
vim.keymap.set("n", "<F7>", function() require("dap").terminate() end)
vim.keymap.set("n", "<F10>", function() dap.step_over() end)
vim.keymap.set("n", "<F11>", function() dap.step_into() end)
vim.keymap.set("n", "<F12>", function() dap.step_out() end)
vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end)
vim.keymap.set("n", "<leader>B", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end)


vim.keymap.set("n", "<F4>", function()
  require("toggleterm").toggle()
end, { noremap = true, silent = true })

vim.keymap.set("t", "<F4>", function()
  require("toggleterm").toggle()
end, { noremap = true, silent = true })

