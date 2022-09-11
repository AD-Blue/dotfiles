local status, numbertoggle = pcall(require, 'aerial')
if (not status) then return end

numbertoggle.setup({})
