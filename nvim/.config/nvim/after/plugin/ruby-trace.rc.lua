-- ruby-lsp guesses a receiver type by capitalizing the variable name and looking
-- for a matching constant, so a param like `target` resolves to nothing and `gd`
-- degrades to listing every RBS stub for that method name. These two commands
-- answer the same questions from the runtime instead of the index.

local ruby = vim.fn.exepath("ruby")
if ruby == "" then return end

-- rdoc 7 cannot unmarshal the ri store shipped with ruby 3.4 (TypeError on load).
local RI = [[
begin; gem "rdoc", "< 7"; rescue Gem::LoadError; end
require "rdoc/ri/driver"
RDoc::RI::Driver.run(["--no-pager", "--format=markdown", *ARGV])
]]

local OWNER = [[
recv, meth = ARGV
obj = eval(recv)
m = obj.respond_to?(meth, true) ? obj.method(meth) : nil
abort("#{recv} does not respond to ##{meth}") unless m
loc = m.source_location
mod = obj.is_a?(Module) ? obj.singleton_class : obj.class
puts "receiver   #{recv}"
puts "class      #{obj.class}"
puts "resolves   #{m.owner}##{meth}"
puts "arity      #{m.arity}    params #{m.parameters.inspect}"
puts "source     #{loc ? "#{loc[0]}:#{loc[1]}" : "(C builtin - no Ruby source)"}"
puts "ancestors  #{mod.ancestors.take(8).join(" < ")}"
]]

local function float(title, lines, ft)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].filetype = ft
  vim.bo[buf].modifiable = false

  local width = math.min(100, math.floor(vim.o.columns * 0.8))
  local height = math.min(math.max(#lines, 3) + 1, math.floor(vim.o.lines * 0.8))
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor", style = "minimal", border = "rounded",
    title = title, title_pos = "center",
    width = width, height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
  })
  vim.wo[win].wrap = true

  for _, key in ipairs({ "q", "<Esc>" }) do
    vim.keymap.set("n", key, "<cmd>close<CR>", { buffer = buf, silent = true })
  end
end

local function run(cmd, cwd, title, ft)
  vim.system(cmd, { text = true, cwd = cwd }, function(res)
    vim.schedule(function()
      local out = vim.trim((res.stdout or "") .. (res.stderr or ""))
      float(title, out == "" and { "(no output)" } or vim.split(out, "\n"), ft)
    end)
  end)
end

-- <cword> stops at `?`/`!`, which are part of the name for predicate methods.
local function method_under_cursor()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2] + 1
  local from = 1
  while true do
    local s, e, word = line:find("([%a_][%w_]*[?!]?)", from)
    if not s then return vim.fn.expand("<cword>") end
    if col >= s and col <= e then return word end
    from = e + 1
  end
end

vim.api.nvim_create_user_command("RubyRi", function(opts)
  local query = opts.args ~= "" and opts.args or method_under_cursor()
  run({ ruby, "-e", RI, "--", query }, nil, " ri " .. query .. " ", "markdown")
end, { nargs = "?", desc = "Docs for every class that defines this method" })

vim.api.nvim_create_user_command("RubyOwner", function(opts)
  local meth = opts.args ~= "" and opts.args or method_under_cursor()
  local root = vim.fs.root(0, { "Gemfile", ".git" }) or vim.uv.cwd()

  vim.ui.input({ prompt = "Receiver expression for #" .. meth .. ": " }, function(recv)
    if not recv or recv == "" then return end
    local cmd = { ruby, "-e", OWNER, "--", recv, meth }
    if opts.bang then cmd = { "bin/rails", "runner", OWNER, recv, meth } end
    run(cmd, root, " " .. meth .. " ", "")
  end)
end, { nargs = "?", bang = true, desc = "Runtime owner + source_location (! boots Rails)" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  callback = function(args)
    local opts = { buffer = args.buf, silent = true }
    vim.keymap.set("n", "<leader>rd", "<cmd>RubyRi<CR>", opts)
    vim.keymap.set("n", "<leader>ro", "<cmd>RubyOwner<CR>", opts)
    vim.keymap.set("n", "<leader>rO", "<cmd>RubyOwner!<CR>", opts)
  end,
})
