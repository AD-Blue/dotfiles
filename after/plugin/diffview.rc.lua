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
