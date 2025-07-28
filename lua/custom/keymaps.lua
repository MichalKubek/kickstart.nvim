local M = {}

local map = function(mode, lhs, rhs, opts, category, unique_identifier, description)
  local wk = require 'which-key'
  if description ~= nil then
    wk.add({ lhs, rhs, desc = description, mode=mode})
  end
end

local wk = require 'which-key'

function M.setup()
  M.projects()
  M.tabs()
  M.files()
  M.spell()
  M.git()
  M.hunk()
  M.test()
  M.buffers()
  M.document()
end

function M.document()
    map('n',
  		'<leader>D',
  		require('telescope.builtin').lsp_type_definitions,
  		{ noremap = true},
  		"Document",
  		"document_type_definition",
  		'Type [D]efinition')
  map('n', '<leader>dd', '<cmd>:windo diffthis<CR>a', { noremap = true, silent = true }, 'Document', 'document_diff', '[d]ocument [d]iff')
end

function M.tabs()
  map('t', '<C-w>l', '<C-\\><C-n><C-w>l', { noremap = true }, 'Console', 'console_move_right', 'Console')
  map('t', '<C-w>j', '<C-\\><C-n><C-w>j', { noremap = true }, 'Console', 'console_move_down', 'Console')
  map('t', '<C-w>k', '<C-\\><C-n><C-w>k', { noremap = true }, 'Console', 'console_move_up', 'Console')
  map('t', '<C-w>h', '<C-\\><C-n><C-w>h', { noremap = true }, 'Console', 'console_move_left', 'Console ')
  map('t', '<C-[>', '<C-\\><C-n>', { noremap = false }, 'Console', 'console_exit', 'Console')

  map('n', ',c', '<cmd>terminal<CR>a', { noremap = true, silent = true }, 'Terminal', 'terminal_create_new', 'create terminal')
  map('n', ',t', '<cmd>tab split<CR>', { noremap = true, silent = true }, 'Tabs', 'tab_create_new', 'Create tab')
  map('n', ',.', '<cmd>tabnext<CR>', { noremap = true, silent = true }, 'Tabs', 'tab_go_next', 'Go to next tab')

  map('n', ',m', '<cmd>tabprevious<CR>', { noremap = true, silent = true }, 'Tabs', 'tab_go_previeous', 'Go to previous tab')

  map('n', '<C-h>', '<C-w>h', { noremap = true, silent = true }, 'Move to left window', 'window_move_left', 'Move to left window')

  map('n', '<C-j>', '<C-w>j', { noremap = true, silent = true }, 'Move window down', 'window_move_down', 'Move down window')

  map('n', '<C-k>', '<C-w>k', { noremap = true, silent = true }, 'Move to up window', 'window_move_up', 'Move to up window')

  map('n', '<C-l>', '<C-w>l', { noremap = true, silent = true }, 'Move window right', 'window_move_right', 'Move right window')
end

function M.spell()
  map('n', '<leader>l]', ']s', { noremap = true, silent = true }, 'Spell', 'spell_go_next', ']s Move to next misspelled word')
  map('n', '<leader>l[', '[s', { noremap = true, silent = true }, 'Spell', 'spell_go_prev', '[s Move to previous misspelled word')
  map('n', '<leader>lg', 'zg', { noremap = true, silent = true }, 'Spell', 'spell_good', 'zg Add word under the cursor as a good word')
  map('n', '<leader>lw', 'zw', { noremap = true, silent = true }, 'Spell', 'spell_bad', "zw Like 'zg' but mark the word as a wrong (bad) word.")
  map('n', '<leader>l=', 'z=', { noremap = true, silent = true }, 'Spell', 'spell_suggest', 'z= suggest correct spelled word')
  map(
    'n',
    '<leader>lr',
    '<cmd>spellr<CR>',
    { noremap = true, silent = true },
    'Spell',
    'spell_repeat',
    ':spellr  Repeat the replacement done by z= for all matches'
  )
end

function M.projects()
  -------------
  -- project --
  -------------
--  wk.register { '<leader>p', group = '+projects' }

  -- <SPC>pp: projects
  map(
    'n',
    '<leader>pp',
    "<cmd>lua require('telescope').extensions.projects.projects()<CR>",
    { noremap = true, silent = true },
    'Projects',
    'telescope_project',
    'Projects'
  )

  -- <SPC>pb: show project buffers
  map(
    'n',
    '<leader>pb',
    "<cmd>lua require('telescope.builtin').buffers({ cwd_only=true })<CR>",
    { noremap = true, silent = true },
    'Projects',
    'switch_project_buffer',
    'Switch to other project buffer'
  )

  -- <SPC>pf: find file in project
  map(
    'n',
    '<leader>pf',
    "<cmd>lua require('telescope.builtin').git_files()<CR>",
    { noremap = true, silent = true },
    'Projects',
    'git_files',
    'Find file in project'
  )

  -- <SPC>pw: change working directory
  map(
    'n',
    '<leader>pw',
    "<cmd>lua require('telescope').extensions.projects.change_working_directory()<CR>",
    { noremap = true, silent = true },
    'Projects',
    'change_working_directory',
    'Change working directory'
  )

  -- <SPC>pf: find file in project
end

function M.files()
  -----------
  -- files --
  -----------
--  wk.register({ ['f'] = { name = '+files' } }, { prefix = '<leader>' })
  wk.add({'<leader>f', group = '[F]iles'})

  -- <SPC>fe: file explorer
  map('n', '<leader>fe', "<cmd>lua require('nvim-tree.api').tree.toggle()<CR>", { noremap = true, silent = true }, 'Files', 'file_explorer', 'File explorer')

  -- <SPC>ff: find file
  map('n', '<leader>ff', "<cmd>lua require('custom.telescope').open_file_browser()<CR>", { noremap = true, silent = true }, 'Files', 'find_files', 'Find file')

  -- <SPC>fs: save file
  map('n', '<leader>fs', '<cmd>w<CR>', { noremap = true, silent = true }, 'Files', 'save_file', 'Save file')

  -- <SPC>fS: save all file
  map('n', '<leader>fS', '<cmd>wa<CR>', { noremap = true, silent = true }, 'Files', 'save_all_files', 'Save all files')

  -- <SPC>fr: find recent file
  map(
    'n',
    '<leader>fr',
    "<cmd>lua require('telescope.builtin').oldfiles()<CR>",
    { noremap = true, silent = true },
    'Files',
    'find_recent_files',
    'Find recently opened file'
  )

  -- <SPC>/: grep for word
  map(
    'n',
    '<leader>/',
    "<cmd>lua require('telescope.builtin').live_grep()<CR>",
    { noremap = true, silent = true },
    'Files',
    'file_grep_shortcut',
    'Grep in current file'
  )

  -- <SPC>fg: file grep
  map(
    'n',
    '<leader>fg',
    "<cmd>lua require('telescope.builtin').live_grep()<CR>",
    { noremap = true, silent = true },
    'Files',
    'file_grep',
    'Grep in current file'
  )

  -- <SPC>*: grep for word under cursor
--  map(
--    'n',
--    '<leader>*',
--    "<cmd>lua require('telescope.builtin').live_grep({ default_text = vim.fn.expand('<cword>') })<CR>",
--    { noremap = true, silent = true },
--    'Files',
--    'string_grep_shortcut',
--    'Grep for word under cursor in current file'
--  )

  -- <SPC>fG: string grep
  map(
    'n',
    '<leader>fG',
    "<cmd>lua require('telescope.builtin').live_grep({ default_text = vim.fn.expand('<cword>') })<CR>",
    { noremap = true, silent = true },
    'Files',
    'string_grep',
    'Grep for word under cursor in current file'
  )
  map(
    'n',
    '<leader>fc',
    "<cmd>lua require('custom.telescope').search_current_directory()<CR>",
    { noremap = true, silent = true },
    'Files',
    'string_grep_directory',
    'Grep in current directory'
  )
  map(
    'n',
    '<leader>fC',
    "<cmd>lua require('custom.telescope').search_current_directory({ default_text = vim.fn.expand('<cword>') })<CR>",
    { noremap = true, silent = true },
    'Files',
    'string_grep_directory_word',
    'Grep word under cursor in current directory'
  )
  map(
    'n',
    '<leader>#',
    "<cmd>lua require('custom.telescope').search_current_directory({ default_text = vim.fn.expand('<cword>') })<CR>",
    { noremap = true, silent = true },
    'Files',
    'string_grep_directory_word_2',
    'Grep word under cursor in current directory'
  )
end

function M.git()
  wk.add({'<leader>g', group = '[G]it'})
  map('n', '<leader>gs', '<cmd>Git<CR>', { noremap = true, silent = true }, 'Git', 'git_status', 'Git [s]status')
  map('n', '<leader>ga', '<cmd>Gwrite<CR>', { noremap = true, silent = true }, 'Git', 'git_add', 'Git [a]dd')
  map('n', '<leader>gc', '<cmd>Git commit<CR>', { noremap = true, silent = true }, 'Git', 'git_commit', 'Git [c]ommit')
  map('n', '<leader>gh', '<cmd>Gread<CR>', { noremap = true, silent = true }, 'Git', 'git_read', 'Git c[h]eckout')
  map('n', '<leader>gr', '<cmd>Gremove<CR>', { noremap = true, silent = true }, 'Git', 'git_remove', 'Git [r]m')
  map('n', '<leader>gb', '<cmd>Git blame<CR>', { noremap = true, silent = true }, 'Git', 'git_blame', 'Git [b]lame')
  map('n', '<leader>gl', '<cmd>Gclog -40<CR>', { noremap = true, silent = true }, 'Git', 'git_log', 'Git [l]og -150')
  map('n', '<leader>gp', '<cmd>Git pull<CR>', { noremap = true, silent = true }, 'Git', 'git_pull', 'Git [p]ull')
  map('n', '<leader>gu', '<cmd>Git push<CR>', { noremap = true, silent = true }, 'Git', 'git_push', 'Git p[u]sh')

  map('n', '<leader>gd', '<cmd>Git diff<CR>', { noremap = true, silent = true }, 'Git', 'git_diff', 'Git [d]iff')
  map('n', '<leader>gD', '<cmd>Git diff --staged<CR>', { noremap = true, silent = true }, 'Git', 'git_diff_staged', 'Git [D]iff --staged')
  map('n', '<leader>gC', '<cmd>Git checkout -- %<CR>', { noremap = true, silent = true }, 'Git', 'git_checkout_current', 'Git [C]heckout -- %')
  map('n', '<leader>gS', '<cmd>Git stash<CR>', { noremap = true, silent = true }, 'Git', 'git_stash', 'Git [S]tash')
  map('n', '<leader>gP', '<cmd>Git stash pop<CR>', { noremap = true, silent = true }, 'Git', 'git_stash_pop', 'Git stash [P]op')
end

function M.buffers()
  wk.add({ "<leader>b", group = '[B]uffers'})

  map('n', '<leader>bd', '<cmd>bd<CR>', { noremap = true, silent = true }, 'buffer', 'buffer_close', 'Unloa[d] current buffer')
  map('n', '<leader>bw', '<cmd>bw<CR>', { noremap = true, silent = true }, 'buffer', 'buffer_wipeout', '[w]ipeout the buffer')
  map('n', '<leader>bn', '<cmd>bn<CR>', { noremap = true, silent = true }, 'buffer', 'buffer_next', '[n]ext buffer')
  map('n', '<leader>bp', '<cmd>bp<CR>', { noremap = true, silent = true }, 'buffer', 'buffer_perevious', '[p]revious buffer')
  map('n', '<leader>bl', '<cmd>Telescope buffers<CR>', { noremap = true, silent = true }, 'buffer', 'buffer_list', 'Buffer [l]ist')
end

function M.test()
--  wk.register({ ['t'] = { name = '+tests' } }, { prefix = '<leader>' })

  map('n', '<leader>ts', '<cmd>Neotest summary<CR>', { noremap = true, silent = true }, 'neotest', 'neotest_summary', 'Neotest summary')

  map('n', '<leader>to', '<cmd>Neotest output<CR>', { noremap = true, silent = true }, 'neotest', 'neotest_output', 'Neotest [o]utput')
  map('n', '<leader>tp', '<cmd>Neotest output-panel<CR>', { noremap = true, silent = true }, 'neotest', 'neotest_output_panel', 'Neotest output [p]anel')
  map('n', '<leader>tr', '<cmd>Neotest run<CR>', { noremap = true, silent = true }, 'neotest', 'neotest_run', 'Neotest [r]un')
  map('n', '<leader>tf', '<cmd>Neotest run file<CR>', { noremap = true, silent = true }, 'neotest', 'neotest_run_file', 'Neotest run tests in [f]ile')
  map('n', '<leader>tl', '<cmd>Neotest run last<CR>', { noremap = true, silent = true }, 'neotest', 'neotest_run_last', 'Neotest run [l]ast tests')
  --[[  summary = {
    enabled = true,
    animated = true,
    follow = true,
    expand_errors = true,
    open = "botright vsplit | vertical resize 50",
    mappings = {
      expand = { "<CR>", "<2-LeftMouse>" },
      expand_all = "e",
      output = "o",
      short = "O",
      attach = "a",
      jumpto = "i"f
      stop = "u",
      run = "r",
      debug = "d",
      mark = "m",
      run_marked = "R",
      debug_marked = "D",
      clear_marked = "M",
      target = "t",
      clear_target = "T",
      next_failed = "J",
      prev_failed = "K",
      watch = "w",
    },
  },
	--]]
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
