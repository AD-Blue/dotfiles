local status, mason = pcall(require, 'mason')
if (not status) then return end

mason.setup()

local status2, masonLspConfig = pcall(require, 'mason-lspconfig')
if (not status2) then return end

masonLspConfig.setup({
  ensure_installed = {
    "tsserver"
  }
})
