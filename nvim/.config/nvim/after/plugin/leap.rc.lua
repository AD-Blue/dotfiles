local status, leap = pcall(require, "leap")
if not status then
	return
end

vim.keymap.set("n", "z", "<Plug>(leap-forward)")
vim.keymap.set("n", "Z", "<Plug>(leap-backward)")
