local status, indentBlankline = pcall(require, 'indent_blankline')
if (not status) then return end

vim.opt.list = true

indentBlankline.setup({
  space_char_blankline = " ",
  show_current_context = true,
})
