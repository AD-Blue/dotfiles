local status, noice = pcall(require, 'noice')
if (not status) then return end

noice.setup({
  lsp = {
    hover = {
      enabled = false
    }
  }
})
