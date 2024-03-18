
return {
	'mireq/luasnip-snippets',
	--lazy = snippet_engine == 'ultisnips',
	lazy = true,
	event = 'InsertEnter',
	dependencies = {'L3MON4D3/LuaSnip'},
	config = function()
		require('luasnip_snippets.common.snip_utils').setup()
	end
}
