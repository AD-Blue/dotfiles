local status, terminal = pcall(require, 'nvim-terminal')
if (not status) then return end

terminal.setup()

