local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'folke/tokyonight.nvim'
  use 'nvim-lualine/lualine.nvim' -- Statusline
  use 'nvim-lua/plenary.nvim' -- Common utilities
  use 'onsails/lspkind-nvim' -- vscode-like pictograms
  use 'hrsh7th/cmp-buffer' -- nvim-cmp source for buffer words
  use 'hrsh7th/cmp-nvim-lsp' -- nvim-cmp source for neovim's built-in LSP
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp' -- Completion
  use 'neovim/nvim-lspconfig' -- LSP
  use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  use 'MunifTanjim/prettier.nvim' -- Prettier plugin for Neovim's built-in LSP client

  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  --  disabling LSP Saga to test out navigator since it's supposed to have similar functionality
  --  use 'glepnir/lspsaga.nvim' -- LSP UIs
  use 'L3MON4D3/LuaSnip'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'kyazdani42/nvim-web-devicons' -- File icons
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag' -- Auto close tags
  use 'norcalli/nvim-colorizer.lua'
  use 'folke/zen-mode.nvim'
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })
  use 'akinsho/nvim-bufferline.lua' -- styled tabs

  use 'lewis6991/gitsigns.nvim'
  use 'dinhhuy258/git.nvim' -- For git blame & browse
  use 'sindrets/diffview.nvim'
  use 'gpanders/editorconfig.nvim' -- For editorconfig
  use({
    "kylechui/nvim-surround", -- For wrapping text in tags, brackets, braces, quotes, etc
    tag = "*", -- Use for stability; omit for the latest features
  })
  use 'stevearc/aerial.nvim'
  use 'sitiom/nvim-numbertoggle'
  use { 'ray-x/guihua.lua', run = 'cd lua/fzy && make' }
  --  disabling Navigator to try out Mason LOL
  --  use 'ray-x/navigator.lua'
  use 'akinsho/toggleterm.nvim'

  use 'rmagatti/auto-session'
  use 'vim-test/vim-test'
  use 'ggandor/leap.nvim'

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    }
  }

  use {
    'folke/noice.nvim',
    requires = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify'
    }
  }

  use 'nacro90/numb.nvim'

  use 'folke/which-key.nvim'

end
)
