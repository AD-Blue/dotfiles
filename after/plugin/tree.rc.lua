local status, tree = pcall(require, 'nvim-tree')
if (not status) then return end

tree.setup()

vim.keymap.set('n', '<leader>th', ':NvimTreeFindFile<CR>')
vim.keymap.set('n', 'tt', ':NvimTreeToggle<CR>')
