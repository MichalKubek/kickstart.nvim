
return {
	"L3MON4D3/LuaSnip",
	version = "2.*",
	--lazy = snippet_engine == 'ultisnips',
	lazy = true,
	event = 'InsertEnter',
	build = "make install_jsregexp",
	dependencies = {
		'nvim-treesitter/nvim-treesitter',
	},
	config = function()
		local ls = require('luasnip')
		ls.setup({
			load_ft_func = require('luasnip_snippets.common.snip_utils').load_ft_func,
			ft_func = require('luasnip_snippets.common.snip_utils').ft_func,
			store_selection_keys = '<c-x>',
			enable_autosnippets = true,
		})
		vim.keymap.set({"i", "s"}, "<Tab>", function() if ls.expand_or_jumpable() then ls.expand_or_jump() else vim.api.nvim_input('<C-V><Tab>') end end, {silent = true})
		vim.keymap.set({"i", "s"}, "<S-Tab>", function() ls.jump(-1) end, {silent = true})
		--vim.api.nvim_set_keymap("i", "<C-n>", "<Plug>luasnip-next-choice", {})
		--vim.api.nvim_set_keymap("s", "<C-n>", "<Plug>luasnip-next-choice", {})
		vim.keymap.set("i", "<C-u>", function() require("luasnip.extras.select_choice")() end, {})
		vim.keymap.set("s", "<C-u>", function() require("luasnip.extras.select_choice")() end, {})

		--vim.keymap.set({"i", "s"}, "<Tab>", function() ls.jump(1) end, {silent = true})
		--vim.cmd("snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>")
		--require("luasnip.loaders.from_lua").lazy_load({
		--	paths = { "./lua/luasnip_snippets/" }
		--})
	end
}
