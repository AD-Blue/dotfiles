require('base')
require('maps')
require('highlights')
require('plugins')

vim.cmd[[colorscheme tokyonight]]
vim.opt.clipboard:append { 'unnamedplus' }

-- lua/localrc.lua holds machine-specific settings and is gitignored, so it is
-- absent on any machine that only clones the dotfiles repo.
if vim.uv.fs_stat(vim.fs.joinpath(vim.fn.stdpath('config'), 'lua', 'localrc.lua')) then
  require('localrc')
end
