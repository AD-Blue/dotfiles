local status, aerial = pcall(require, 'aerial')
if (not status) then return end

aerial.setup({})

vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>', {})
