local status, conform = pcall(require, 'conform')
if (not status) then return end

conform.setup({
  formatters = {
    rubocop_layout = {
      command = "bundle",
      args = {
        "exec", "rubocop", "--server", "-a", "--only", "Layout",
        "--force-exclusion", "-f", "quiet", "--stderr", "--stdin", "$FILENAME",
      },
      cwd = function(_, ctx)
        return vim.fs.root(ctx.dirname, ".git")
      end,
      exit_codes = { 0, 1 },
    },
  },
  formatters_by_ft = {
    ruby = { "rubocop_layout" },
    lua = { "stylua" },
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    css = { "prettierd" },
    html = { "prettierd" },
    json = { "prettierd" },
    yaml = { "prettierd" },
    markdown = { "prettierd" },
    graphql = { "prettierd" },
    handlebars = { "prettierd" },
  },
  format_on_save = function(bufnr)
    if vim.bo[bufnr].filetype == "ruby" then
      return { timeout_ms = 4000, lsp_format = "never" }
    end
    return { timeout_ms = 500, lsp_format = "fallback" }
  end,
})
