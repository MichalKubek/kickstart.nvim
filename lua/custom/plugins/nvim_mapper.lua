
return { 'lazytanuki/nvim-mapper',
    config = function()
      require("nvim-mapper").setup({
        no_map = false, -- do not assign the default keymap
        search_path = vim.fn.stdpath("config") .. "/lua",
      })
    end,
  }
