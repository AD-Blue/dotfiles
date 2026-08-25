local status, treesitter = pcall(require, "nvim-treesitter")
if (not status) then return end

treesitter.setup()

treesitter.install({
  "tsx",
  "json",
  "yaml",
  "css",
  "html",
  "lua",
  "rust",
  "markdown",
  "markdown_inline",
})

-- highlighting/indent are core Neovim features now; nvim-treesitter (main)
-- only ships the parsers/queries. pcall guards filetypes with no parser.
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
    pcall(function()
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end)
  end,
})
