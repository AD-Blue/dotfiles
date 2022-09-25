local status, diffview = pcall(require, "diffview")
if (not status) then return end

diffview.setup({
  use_icons = true,         -- Requires nvim-web-devicons
  view = {
    default = {
      layout = "diff2_horizontal"
    },
    merge_tool = {
      layout = "diff3_mixed"
    }
  }
})

vim.keymap.set('n', '<leader>vo', ':DiffviewOpen<Return>')
vim.keymap.set('n', '<leader>vc', ':DiffviewClose<Return>')
