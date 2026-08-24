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
    "windwp/nvim-ts-autotag",
    'nvim-lua/plenary.nvim',
    'rmagatti/auto-session',

    {
      'm-demare/hlargs.nvim',
      dependencies = {
        "nvim-treesitter/nvim-treesitter"
      }
    },

    -- Telescope
    {
      'nvim-telescope/telescope.nvim',
      dependencies = { { 'nvim-lua/plenary.nvim' } }
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-telescope/telescope-file-browser.nvim',

    'windwp/nvim-autopairs',

    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

    'nvim-tree/nvim-web-devicons',
    'nvim-lualine/lualine.nvim',

    -- LSP
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    {
      "nvimtools/none-ls.nvim",
      dependencies = {
        "nvimtools/none-ls-extras.nvim",
      },
    },
    -- CMP
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',

    {
    	"L3MON4D3/LuaSnip",
    	version = "v2.*",
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

    { 'akinsho/bufferline.nvim', dependencies = 'nvim-tree/nvim-web-devicons' },

    {
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
      dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" }
    },

    {
      "rmagatti/goto-preview",
      dependencies = { "rmagatti/logger.nvim" },
      event = "BufEnter",
      config = true
    },

    {
      "pwntester/octo.nvim",
      cmd = "Octo",
      opts = {
        -- or "fzf-lua" or "snacks" or "default"
        picker = "telescope",
        -- bare Octo command opens picker of commands
        enable_builtin = true,
        use_local_fs = true
      },
      keys = {
        {
          "<leader>op",
          "<CMD>Octo pr list<CR>",
          desc = "List GitHub PullRequests",
        },
        {
          "<leader>on",
          "<CMD>Octo notification list<CR>",
          desc = "List GitHub Notifications",
        },
      },
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        -- OR "ibhagwan/fzf-lua",
        -- OR "folke/snacks.nvim",
        "nvim-tree/nvim-web-devicons", -- optional if file_panel.icons is a function
      },
    },

    {
      "rmagatti/goto-preview",
      dependencies = { "rmagatti/logger.nvim" },
      event = "BufEnter",
      config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
    },

    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
      keys = {
        {
          "<leader>?",
          function()
            require("which-key").show({ global = false })
          end,
          desc = "Buffer Local Keymaps (which-key)",
        },
      },
    }
  }
)
