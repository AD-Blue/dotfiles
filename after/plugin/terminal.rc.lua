local status, terminal = pcall(require, 'toggleterm')
if (not status) then return end

terminal.setup({
  open_mapping = [[<leader>;]],

  size = 20
})

vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])
