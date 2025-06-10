return {
  "ahmedkhalf/project.nvim",
  lazy = false,
  config = function()
    require("project_nvim").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      sync_root_with_cwd = true,
      cd_scope = 'project',
      respect_buf_cwd = true,
      silent_chdir = false,
      update_focused_file = {
        enable = true,
        update_root = true
      },
      require('telescope').load_extension('projects'),
    }
  end
}
