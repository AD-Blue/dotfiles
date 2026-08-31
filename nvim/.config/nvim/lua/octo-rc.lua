local status, octo = pcall(require, 'octo')
if (not status) then return end

octo.setup({
  picker = "telescope",
  enable_builtin = true,
  use_local_fs = true,
})

local navigation = require("octo.navigation")
local go_to_file = navigation.go_to_file
navigation.go_to_file = function()
  local props = vim.b.octo_diff_props

  if not props then
    return go_to_file()
  end

  local line = vim.api.nvim_win_get_cursor(0)[1]
  local target = vim.fs.joinpath(vim.fn.getcwd(), props.path)
  local eventignore = vim.o.eventignore
  vim.o.eventignore = "BufEnter"
  local opened = pcall(vim.cmd, "tabedit " .. vim.fn.fnameescape(target))
  vim.o.eventignore = eventignore

  if not opened then
    return
  end

  vim.cmd("diffoff")
  vim.wo.foldmethod = "manual"
  vim.bo.modifiable = true
  pcall(vim.api.nvim_win_set_cursor, 0, { line, 0 })
end

local utils = require("octo.utils")
local get_repo_info = utils.get_repo_info

utils.get_repo_info = function(repo)
  local info = get_repo_info(repo)
  local branch = vim.trim(vim.fn.system("git rev-parse --abbrev-ref HEAD"))
  vim.fn.system { "git", "rev-parse", "--verify", "--quiet", "refs/remotes/origin/" .. branch }
  local nodes = vim.tbl_get(info or {}, "refs", "nodes")

  if vim.v.shell_error == 0 and type(nodes) == "table" then
    table.insert(nodes, { name = branch })
  end

  return info
end
