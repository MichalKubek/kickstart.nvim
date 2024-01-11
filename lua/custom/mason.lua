local M = {}

local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},
  -- html = { filetypes = { 'html', 'twig', 'hbs'} },

  lua_ls = {
    Lua = {
      workspace = {
	checkThirdParty = false,
	library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = { enable = false },
    },
  },
  pylsp = {
    pylsp = {
      plugins = {
	pycodestyle = {
	  ignore = {'W391', 'W191'},
	  maxLineLength = 130
	},
	ruff = {
	  enabled = true,  -- Enable the plugin
	  executable = "<path-to-ruff-bin>",  -- Custom path to ruff
	  path = "<path_to_custom_ruff_toml>",  -- Custom config for ruff to use
	  extendSelect = { "I" },  -- Rules that are additionally used by ruff
	  extendIgnore = { "C90" },  -- Rules that are additionally ignored by ruff
	  format = { "I" },  -- Rules that are marked as fixable by ruff that should be fixed when running textDocument/formatting
	  severities = { ["D212"] = "I" },  -- Optional table of rules where a custom severity is desired
	  unsafeFixes = false,  -- Whether or not to offer unsafe fixes as code actions. Ignored with the "Fix All" action

	  -- Rules that are ignored when a pyproject.toml or ruff.toml is present:
	  lineLength = 100,  -- Line length to pass to ruff checking and formatting
	  exclude = { "__about__.py" },  -- Files to be excluded by ruff checking
	  select = { "F" },  -- Rules to be enabled by ruff
	  ignore = { "D210", "W191" },  -- Rules to be ignored by ruff
	  perFileIgnores = { ["__init__.py"] = "CPY001" },  -- Rules that should be ignored for specific files
	  preview = false,  -- Whether to enable the preview style linting and formatting.
	  targetVersion = "py310",  -- The minimum python version to target (applies for both linting and formatting).
	},

      }
    }
  },

}

function M.setup()
	-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

	-- Ensure the servers above are installed
	local mason_lspconfig = require 'mason-lspconfig'

	mason_lspconfig.setup {
		ensure_installed = {"pylsp", "ruff_lsp", "lua_ls"} -- vim.tbl_keys(servers)
	}

	mason_lspconfig.setup_handlers {
		function(server_name)
			require('lspconfig')[server_name].setup {
				capabilities = capabilities,
				on_attach = on_attach,
				settings = servers[server_name],
				filetypes = (servers[server_name] or {}).filetypes,
			}
		end,
	}

end


return M