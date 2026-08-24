local status, harpoon = pcall(require, 'harpoon')
if (not status) then return end

harpoon.setup()


local telescopeConfig = require("telescope.config").values

-- replace the call to defaultHarpoonList with this one if you want to use telescope for the harpoon list GUI
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
      table.insert(file_paths, item.value)
  end

  require("telescope.pickers").new({}, {
      prompt_title = "Harpoon",
      finder = require("telescope.finders").new_table({
          results = file_paths,
          initial_mode = 'normal'
      }),
      previewer = telescopeConfig.file_previewer({}),
      sorter = telescopeConfig.generic_sorter({}),
  }):find()
end

local function defaultHarpoonList(harpoon_files)
  harpoon.ui:toggle_quick_menu(harpoon_files)
end

vim.keymap.set("n", "<leader>h", function() harpoon:list():add() end, { desc = "Add file to Harpoon list" })
vim.keymap.set("n", "<leader>l", function() defaultHarpoonList(harpoon:list()) end, { desc = "Open Harpoon list"})
vim.keymap.set("n", "<leader>jn", function() harpoon:list():next() end, { desc = "Next file in Harpoon list" })
vim.keymap.set("n", "<leader>jp", function() harpoon:list():prev() end, { desc = "Previous file in Harpoon list" })
