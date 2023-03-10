
local M = {}

function M.setup()
  print("Ahoj")
  local telescope = require("telescope")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local previewers = require("telescope.previewers")
  local fb_utils = require("telescope._extensions.file_browser.utils")
  local fb_actions = require("telescope._extensions.file_browser.actions")

  local file_browser_change_dir = function(path)
    local prompt_bufnr = vim.api.nvim_get_current_buf()
    local current_picker = action_state.get_current_picker(prompt_bufnr)
    local finder = current_picker.finder
    finder.path = path

    fb_utils.redraw_border_title(current_picker)
    current_picker:refresh(finder, { reset_prompt = true, multi = current_picker._multi })
  end

  local buffer_previewer_maker = function(filepath, bufnr, opts)
    opts = opts or {}
    filepath = vim.fn.expand(filepath)
    -- Job:new({
    --     command = "file",
    --     args = { "--mime-type", "-b", filepath },
    --     on_exit = function(j)
    --       local mime_type = vim.split(j:result()[1], "/")[1]
    --       if mime_type == "text" then
    --         vim.loop.fs_stat(filepath, function(_, stat)
    --           if stat and stat.size <= 100000 then
    --             previewers.buffer_previewer_maker(filepath, bufnr, opts)
    --           end
    --         end)
    --       else
    --         vim.schedule(function()
    --           vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "---< binary file >---" })
    --         end)
    --       end
    --     end
    --   }):sync()
    vim.loop.fs_stat(filepath, function(_, stat)
      if stat and stat.size <= 100000 then
        previewers.buffer_previewer_maker(filepath, bufnr, opts)
      end
    end)
  end

  telescope.setup({
    defaults = {
      find_command = {
        "rg",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--trim",
      },
--      initial_mode = "insert",
--      selection_strategy = "reset",
--      sorting_strategy = "descending",
--      layout_strategy = "horizontal",
--      prompt_prefix = "   ",
--      selection_caret = " ",
--
      layout_config = {
        horizontal = {
--          preview_width = 0.75,
        },
      },

      buffer_previewer_maker = buffer_previewer_maker,
--      file_sorter = require("telescope.sorters").get_fuzzy_file,
--      file_ignore_patterns = { ".git", "node_modules", "__pycache__", ",build" },G
--      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
--
--      winblend = 0,
--      scroll_strategy = "cycle",
--      border = {},
--      color_devicons = true,
--      use_less = true,
--      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
--
--      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
--      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
--      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
--      buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
--
--      mappings = {
--        i = {
--          ["<C-j>"] = actions.move_selection_next,
--          ["<C-k>"] = actions.move_selection_previous,
--          ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
--          -- ["<Leader>f"] = actions.close, -- works like a toggle, sometimes can be buggy
--          -- ["<ESC>"] = actions.close,
--          ["<CR>"] = actions.select_default + actions.center,
--        },
--        n = {
--          ["<C-j>"] = actions.move_selection_next,
--          ["<C-k>"] = actions.move_selection_previous,
--          ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
--        },
--      },
    },
    extensions = {
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
      },
      file_browser = {
        mappings = {
          ["i"] = {
            ["<A-c>"] = fb_actions.create,
            ["<A-r>"] = fb_actions.rename,
            ["<A-m>"] = fb_actions.move,
            ["<A-y>"] = fb_actions.copy,
            ["<A-d>"] = fb_actions.remove,
            ["<C-o>"] = fb_actions.open,
            ["<C-h>"] = fb_actions.goto_parent_dir,
            ["<C-~>"] = fb_actions.goto_home_dir,
            ["<C-w>"] = fb_actions.goto_cwd,
            ["<C-t>"] = fb_actions.change_cwd,
            ["<C-f>"] = fb_actions.toggle_browser,
            ["<C-s>"] = fb_actions.toggle_hidden,
            ["<C-a>"] = fb_actions.toggle_all,
          },
          ["n"] = {
            ["c"] = fb_actions.create,
            ["r"] = fb_actions.rename,
            ["m"] = fb_actions.move,
            ["y"] = fb_actions.copy,
            ["d"] = fb_actions.remove,
            ["o"] = fb_actions.open,
            ["h"] = fb_actions.goto_parent_dir,
            ["~"] = fb_actions.goto_home_dir,
            ["w"] = fb_actions.goto_cwd,
            ["t"] = fb_actions.change_cwd,
            ["f"] = fb_actions.toggle_browser,
            ["s"] = fb_actions.toggle_hidden,
            ["a"] = fb_actions.toggle_all,
          },
        },
        on_input_filter_cb = function(prompt)
          if prompt == '~/' then
            file_browser_change_dir(vim.loop.os_homedir())
          elseif prompt == '/' then
            file_browser_change_dir('/')
          end
        end,
      },

    },
  })

--  telescope.load_extension "mapper"
  telescope.load_extension "fzf"
  telescope.load_extension "file_browser"
  telescope.load_extension "projects"
end

function M.open_file_browser()
  local Path = require("plenary.path")
  local path = vim.api.nvim_buf_get_name(0)
  if path ~= '' then
    path = Path:new(path):parent()["filename"]
  else
    path = nil
  end
  require("telescope").extensions.file_browser.file_browser({ cwd = path })
end

function M.search_current_directory(opts)
  local Path = require("plenary.path")
  local path = vim.api.nvim_buf_get_name(0)
  if path ~= '' then
    path = Path:new(path):parent()["filename"]

    opts = opts or {}
    opts = vim.tbl_extend("error", opts, {
      cwd = path,
    })

    require('telescope.builtin').live_grep(opts)
  end
end

return M
