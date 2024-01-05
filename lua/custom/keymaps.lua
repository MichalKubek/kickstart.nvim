local M = {}

local map = function(mode, lhs, rhs, opts, category, unique_identifier, description)
  local wk = require("which-key")
  local mapper = require("nvim-mapper")
  if description ~= nil then
    wk.register({ [lhs] = { description } })
  end
  mapper.map(mode, lhs, rhs, opts, category, unique_identifier, description)
end

local wk = require("which-key")


function M.setup()
	M.projects()
	M.tabs()
	M.files()
end

function M.tabs()

	map("n",
		",t",
		"<cmd>tab split<CR>",
		{ noremap=true, silent=true },
		"Tabs",
		"tab_create_new",
		"Create tab")
	map("n",
		",.",
		"<cmd>tabnext<CR>",
		{ noremap=true, silent=true },
		"Tabs",
		"tab_go_next",
		"Go to next tab")

	map("n",
		",m",
		"<cmd>tabprevious<CR>",
		{ noremap=true, silent=true },
		"Tabs",
		"tab_go_previeous",
		"Go to previous tab")

	map("n",
		"<C-h>",
		"<C-w>h",
		{ noremap=true, silent=true },
		"Move to left window",
		"window_move_left",
		"Move to left window")

	map("n",
		"<C-j>",
		"<C-w>j",
		{ noremap=true, silent=true },
		"Move window down",
		"window_move_down",
		"Move down window")



	map("n",
		"<C-k>",
		"<C-w>k",
		{ noremap=true, silent=true },
		"Move to up window",
		"window_move_up",
		"Move to up window")

	map("n",
		"<C-l>",
		"<C-w>l",
		{ noremap=true, silent=true },
		"Move window right",
		"window_move_right",
		"Move right window")

end

function M.projects()
	-------------
	-- project --
	-------------
	wk.register({ ["p"] = { name = "+projects" } }, { prefix = "<leader>" })

	-- <SPC>pp: projects
	map("n",
		"<leader>pp",
		"<cmd>lua require('telescope').extensions.projects.projects()<CR>",
		{ noremap=true, silent=true },
		"Projects",
		"telescope_project",
		"Projects")

	-- <SPC>pb: show project buffers
	map("n",
		"<leader>pb",
		"<cmd>lua require('telescope.builtin').buffers({ cwd_only=true })<CR>",
		{ noremap=true, silent=true },
		"Projects",
		"switch_project_buffer",
		"Switch to other project buffer")

	-- <SPC>pf: find file in project
	map("n",
		"<leader>pf",
		"<cmd>lua require('telescope.builtin').git_files()<CR>",
		{ noremap=true, silent=true },
		"Projects",
		"git_files",
		"Find file in project")

	-- <SPC>pw: change working directory
	map("n",
		"<leader>pw",
		"<cmd>lua require('telescope').extensions.projects.change_working_directory()<CR>",
		{ noremap=true, silent=true },
		"Projects",
		"change_working_directory",
		"Change working directory")

end

function M.files()

	-----------
	-- files --
	-----------
	wk.register({ ["f"] = { name = "+files" } }, { prefix = "<leader>" })

	-- <SPC>fe: file explorer
	map("n",
		"<leader>fe",
		"<cmd>lua require('nvim-tree').toggle()<CR>",
		{ noremap=true, silent=true },
		"Files",
		"file_explorer",
		"File explorer")

	-- <SPC>ff: find file
	local lol = require('custom.telescope')
	map("n",
		"<leader>ff",
		"<cmd>lua require('custom.telescope').open_file_browser()<CR>",
		{ noremap=true, silent=true },
		"Files",
		"find_files",
		"Find file")

	-- <SPC>fs: save file
	map("n",
		"<leader>fs",
		"<cmd>w<CR>",
		{ noremap=true, silent=true },
		"Files",
		"save_file",
		"Save file")

	-- <SPC>fS: save all file
	map("n",
		"<leader>fS",
		"<cmd>wa<CR>",
		{ noremap=true, silent=true },
		"Files",
		"save_all_files",
		"Save all files")

	-- <SPC>fr: find recent file
	map("n",
		"<leader>fr",
		"<cmd>lua require('telescope.builtin').oldfiles()<CR>",
		{ noremap=true, silent=true },
		"Files",
		"find_recent_files",
		"Find recently opened file")

	-- <SPC>/: grep for word
	map("n",
		"<leader>/",
		"<cmd>lua require('telescope.builtin').live_grep()<CR>",
		{ noremap=true, silent=true },
		"Files",
		"file_grep_shortcut",
		"Grep in current file")

	-- <SPC>fg: file grep
	map("n",
		"<leader>fg",
		"<cmd>lua require('telescope.builtin').live_grep()<CR>",
		{ noremap=true, silent=true },
		"Files",
		"file_grep",
		"Grep in current file")

	-- <SPC>*: grep for word under cursor
	map("n",
		"<leader>*",
		"<cmd>lua require('telescope.builtin').live_grep({ default_text = vim.fn.expand('<cword>') })<CR>",
		{ noremap=true, silent=true },
		"Files",
		"string_grep_shortcut",
		"Grep for word under cursor in current file")

	-- <SPC>fG: string grep
	map("n",
		"<leader>fG",
		"<cmd>lua require('telescope.builtin').live_grep({ default_text = vim.fn.expand('<cword>') })<CR>",
		{ noremap=true, silent=true },
		"Files",
		"string_grep",
		"Grep for word under cursor in current file")
	vim.keymap.set('n', '<leader>b', require('telescope.builtin').buffers, { desc = '[b] Find existing buffers' })

end

return M
