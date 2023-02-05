local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require('lazy').setup(
  {
    'folke/tokyonight.nvim',
    {
      'nvim-treesitter/nvim-treesitter',
      build = function()
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
      end,
    },
    'nvim-lua/plenary.nvim',
    'rmagatti/auto-session',

    -- Telescope
    {
      'nvim-telescope/telescope.nvim',
      dependencies = { { 'nvim-lua/plenary.nvim' } }
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-telescope/telescope-file-browser.nvim',

    'windwp/nvim-autopairs',
    'lukas-reineke/indent-blankline.nvim',
    'nvim-tree/nvim-web-devicons',
    'nvim-lualine/lualine.nvim',

    -- LSP
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'jose-elias-alvarez/null-ls.nvim',

    -- CMP
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',

    {
      'L3MON4D3/LuaSnip',
      build = "make install_jsregexp"
    },

    {
      'SmiteshP/nvim-navic',
      dependencies = 'neovim/nvim-lspconfig'
    },

    'ggandor/leap.nvim',
    'kylechui/nvim-surround',
    'nvim-tree/nvim-tree.lua',

    -- git stuff
    {
      'sindrets/diffview.nvim',
      dependencies = 'nvim-lua/plenary.nvim'
    },
    'dinhhuy258/git.nvim',
    'lewis6991/gitsigns.nvim',

    'stevearc/aerial.nvim',
    'sitiom/nvim-numbertoggle',
    'vim-test/vim-test',
    'nacro90/numb.nvim',

    { 'akinsho/bufferline.nvim', dependencies = 'nvim-tree/nvim-web-devicons' }

  }
)
