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
	M.spell()
	M.git()
	M.hunk()
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


function M.spell()
	wk.register({ ["l"] = { name = "+spe[L]l" } }, { prefix = "<leader>" })
	map("n",
		"<leader>l]",
		"]s",
		{ noremap=true, silent=true },
		"Spell",
		"spell_go_next",
		"]s Move to next misspelled word")
	map("n",
		"<leader>l[",
		"[s",
		{ noremap=true, silent=true },
		"Spell",
		"spell_go_prev",
		"[s Move to previous misspelled word")
	map("n",
		"<leader>lg",
		"zg",
		{ noremap=true, silent=true },
		"Spell",
		"spell_good",
		"zg Add word under the cursor as a good word")
	map("n",
		"<leader>lw",
		"zw",
		{ noremap=true, silent=true },
		"Spell",
		"spell_bad",
		"zw Like 'zg' but mark the word as a wrong (bad) word.")
	map("n",
		"<leader>l=",
		"z=",
		{ noremap=true, silent=true },
		"Spell",
		"spell_suggest",
		"z= suggest correct spelled word")
	map("n",
		"<leader>lr",
		"<cmd>spellr<CR>",
		{ noremap=true, silent=true },
		"Spell",
		"spell_repeat",
		":spellr  Repeat the replacement done by z= for all matches")


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

end

function M.git()
	map("n",
		"<leader>gs",
		"<cmd>Git<CR>",
		{ noremap=true, silent=true },
		"Git",
		"git_status",
		"Git [S]status")
	map("n",
		"<leader>ga",
		"<cmd>Gwrite<CR>",
		{ noremap=true, silent=true },
		"Git",
		"git_add",
		"Git [A]dd")
	map("n",
		"<leader>gc",
		"<cmd>Git commit<CR>",
		{ noremap=true, silent=true },
		"Git",
		"git_commit",
		"Git [C]ommit")
	map("n",
		"<leader>gh",
		"<cmd>Gread<CR>",
		{ noremap=true, silent=true },
		"Git",
		"git_read",
		"Git c[H]eckout")
	map("n",
		"<leader>gr",
		"<cmd>Gremove<CR>",
		{ noremap=true, silent=true },
		"Git",
		"git_remove",
		"Git [R]m")
	map("n",
		"<leader>gb",
		"<cmd>G blame<CR>",
		{ noremap=true, silent=true },
		"Git",
		"git_blame",
		"Git [B]lame")
	map("n",
		"<leader>gl",
		"<cmd>Gclog -40<CR>",
		{ noremap=true, silent=true },
		"Git",
		"git_log",
		"Git [L]og -40")
	map("n",
		"<leader>gp",
		"<cmd>Git pull<CR>",
		{ noremap=true, silent=true },
		"Git",
		"git_pull",
		"Git [P]ull")
	map("n",
		"<leader>gu",
		"<cmd>Git push<CR>",
		{ noremap=true, silent=true },
		"Git",
		"git_push",
		"Git p[U]sh")
end

function M.hunk()
        local gs = package.loaded.gitsigns
        local function hmap(mode, l, r, opts)
          opts = opts or {}
          vim.keymap.set(mode, l, r, opts)
        end
        hmap('n', '<leader>h]', gs.next_hunk, { desc = ']c Next hunk' })
        hmap('n', '<leader>h[', gs.prev_hunk, { desc = '[c Previous hunk' })
end
return M
