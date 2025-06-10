
return {
    'nvim-web-devicons',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    setup = function()

        require('nvim-web-devicons').setup()
        require'nvim-web-devicons'.get_icons_by_filename()
        require'nvim-web-devicons'.get_icons_by_extension()
        require'nvim-web-devicons'.get_icons_by_operating_system()
        require'nvim-web-devicons'.get_icons_by_desktop_environment()
        require'nvim-web-devicons'.get_icons_by_window_manager()
    end
}
