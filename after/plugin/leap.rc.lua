local status, leap = pcall(require, 'leap')
if (not status) then return end

leap.setup({})

vim.keymap.set('n', 'z', '<Plug>(leap-forward-to)')
vim.keymap.set('n', 'Z', '<Plug>(leap-backward-to)')
