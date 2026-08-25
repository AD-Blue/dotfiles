local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  -- Telescope shows a picker with preview when a symbol resolves to several
  -- definitions, the normal case for a method on a receiver ruby-lsp cannot infer.
  vim.keymap.set('n', 'gd', function()
    local ok, builtin = pcall(require, 'telescope.builtin')
    if ok then builtin.lsp_definitions() else vim.lsp.buf.definition() end
  end, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
end

vim.lsp.config('*', {
  capabilities = capabilities,
  on_attach = on_attach,
})

vim.lsp.config('ts_ls', {
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" },
  init_options = {
    preferences = {
      importModuleSpecifierPreference = "relative"
    }
  }
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },

      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false
      },
    },
  },
})

vim.lsp.config('ruby_lsp', {
  -- --use-launcher: boot gracefully in monorepos/worktrees where the nearest
  -- (nested service) Gemfile has no committed Gemfile.lock, and degrade to a
  -- minimal bundle instead of crashing when app gems can't be installed.
  -- Avoids per-worktree `bundle install` in service dirs (exit 78 / exit 1).
  cmd = { "ruby-lsp", "--use-launcher" },
})

vim.lsp.config('rubocop', {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    on_attach(client, bufnr)
  end,
})

vim.lsp.enable({ 'ts_ls', 'lua_ls' })
