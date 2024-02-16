local status, ibl = pcall(require, 'ibl')
if (not status) then return end

local highlight = {
  "RainbowRed",
  "RainbowYellow",
  "RainbowBlue",
  "RainbowOrange",
  "RainbowGreen",
  "RainbowViolet",
  "RainbowCyan",
}

local hooks = require('ibl.hooks')

hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#ff757f" })
  vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#ffc777" })
  vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#65bcff" })
  vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#ff966c" })
  vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#c3e88d" })
  vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#fca7ea" })
  vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#86e1fc" })
end
)

ibl.setup({
  scope = {
    enabled = true,
    show_start = true,
    show_end = true,
    highlight = { "Function", "Label" },
    priority = 500,

  }
})
