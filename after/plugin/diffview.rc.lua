local status, diffview = pcall(require, 'diffview')
local actions = require('diffview.actions')
if (not status) then return end

diffview.setup({
  use_icons = true, -- for nvim-web-devicons, optional
  view = {
    default = {
      layout = "diff2_horizontal"
    },
    merge_tool = {
      layout = "diff3_mixed"
    }
  },
  keymaps = {
    view = {
      { "n", "<leader>ct", actions.conflict_choose("theirs"), { desc = "Choose the THEIRS version of a conflict" } },
      { "n", "<leader>cb", actions.conflict_choose("base"), { desc = "Choose the BASE version of a conflict" } },
      { "n", "<leader>ca", actions.conflict_choose("all"), { desc = "Choose all the versions of a conflict" } },
    }
  }
})

vim.keymap.set('n', '<leader>vo', ':DiffviewOpen<Return>')
vim.keymap.set('n', '<leader>vc', ':DiffviewClose<Return>')
