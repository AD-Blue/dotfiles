local status, treesitter = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

treesitter.setup {
  highlight = {
    enable = true
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    "tsx",
    "json",
    "yaml",
    "css",
    "html",
    "lua",
    "rust"
  },
  autotag = {
    enable = true,
  },
  incremental_selection = { -- smart select. Hit enter in a treesitter supported language to start
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      scope_incremental = '<CR>',
      node_incremental = '<TAB>',
      node_decremental = '<S-TAB>',
    },
  }
}
