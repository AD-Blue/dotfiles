local keymap = vim.keymap

vim.g.mapleader = "\\"

keymap.set('n', 'x', '"_x')

-- Increment/decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- Delete a word backwards
keymap.set('n', 'db', 'vb"_d')

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- New tab
keymap.set('n', 'te', ':tabedit<Return>')
-- Move between tabs
keymap.set('n', 'tp', ':tabp<Return>')
keymap.set('n', 'tn', ':tabn<Return>')

-- Split window
keymap.set('n', 'ss', ':split<Return><C-w>w')
keymap.set('n', 'sv', ':vsplit<Return><C-w>w')
-- Move window
keymap.set('n', '<Tab>', '<C-w>w', { noremap = true })
keymap.set('', 'sh', '<C-w>h')
keymap.set('', 'sk', '<C-w>k')
keymap.set('', 'sj', '<C-w>j')
keymap.set('', 'sl', '<C-w>l')

-- Resize window
keymap.set('n', '<C-w><left>', '<C-w><')
keymap.set('n', '<C-w><right>', '<C-w>>')
keymap.set('n', '<C-w><up>', '<C-w>+')
keymap.set('n', '<C-w><down>', '<C-w>-')

keymap.set('n', ';,',
  function()
    vim.diagnostic.open_float()
  end
)

-- Testing
keymap.set('n', '<leader>tf', ':TestFile<Return>')  -- Run all tests in file
keymap.set('n', '<leader>ts', ':TestSuite<Return>') -- Run all tests in test suite
keymap.set('n', '<leader>tn', ':TestNearest<Return>') -- Run test that's closest to the cursor
