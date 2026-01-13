return {
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { {
			"mason-org/mason.nvim",
			opts = {}
		} },
		config = function(opts)
			local on_attach = function(event)
				-- Enable completion triggered by <c-x><c-o>
				local map = function(keys, func, desc, mode)
					mode = mode or 'n'
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
				end

				-- Rename the variable under your cursor.
				--  Most Language Servers support renaming across files, etc.
				map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

				-- Execute a code action, usually your cursor needs to be on top of an error
				-- or a suggestion from your LSP for this to activate.
				map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

				-- Find references for the word under your cursor.
				map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

				-- Jump to the implementation of the word under your cursor.
				--  Useful when your language has ways of declaring types without an actual implementation.
				map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

				-- Jump to the definition of the word under your cursor.
				--  This is where a variable was first declared, or where a function is defined, etc.
				--  To jump back, press <C-t>.
				map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

				-- WARN: This is not Goto Definition, this is Goto Declaration.
				--  For example, in C this would take you to the header.
				-- map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

				-- Fuzzy find all the symbols in your current document.
				--  Symbols are things like variables, functions, types, etc.
				map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

				-- Fuzzy find all the symbols in your current workspace.
				--  Similar to document symbols, except searches over your entire project.
				map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

				-- Jump to the type of the word under your cursor.
				--  Useful when you're not sure what type a variable is and you want to see
				--  the definition of its *type*, not where it was *defined*.

				map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')
				local bufopts = { noremap = true, silent = true, buffer = event.buf }
				-- vim.api.nvim_buf_set_option(event.buf, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
				map('gD', vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				map('gd', vim.lsp.buf.definition, "[G]oto [D]efinition")
				map('K', vim.lsp.buf.hover, "[K] Hover Documentation")
				map('gi', vim.lsp.buf.implementation, "[G]oto [I]mplementation")
				map('<leader>k', vim.lsp.buf.signature_help, "Signature Help")
				map('<space>wa', vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
				map('<space>wr', vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
				map('<space>wl', function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, "[W]orkspace [L]ist Folders")
				map('<space>D', vim.lsp.buf.type_definition, "[T]ype [D]efinition")
				map('<space>fr', vim.lsp.buf.format, "[F]o[r]mat File")
				map('<space>e', vim.diagnostic.open_float, "Open Diagnostic Float")
			end
			vim.api.nvim_create_autocmd('LspAttach', {
				callback = on_attach,
			})
			local capabilities = require('blink.cmp').get_lsp_capabilities()
			vim.lsp.config('*', {
				capabilities = capabilities,
			})
			vim.lsp.config('ty', {
				settings = {
					ty = {
						disableLanguageServices = true,
					},
				},
			})
			vim.lsp.config('ruff',{})
			vim.lsp.enable({ 'basedpyright', 'lua_ls', 'ruff', 'ty' })
		end
	},

	{
		'saghen/blink.cmp',
		-- optional: provides snippets for the snippet source
		dependencies = { 'rafamadriz/friendly-snippets' },

		enabled = function() return not vim.tbl_contains({"markdown","vimwiki"}, vim.bo.filetype)  end,
		-- use a release tag to download pre-built binaries
		version = '1.*',
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
			keymap = {
				preset = 'default',
				['<tab>'] = { 'insert_next', 'fallback' },
				['<s-tab>'] = { 'select_prev', 'fallback' },
				['<C-l>'] = { 'accept', 'fallback' },
			},


			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = 'mono'
			},

			-- (Default) Only show the documentation popup when manually triggered
			completion = { documentation = { auto_show = true },
			list= {selection={preselect=false}}
		    },

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { 'lsp', 'path', 'snippets', 'lazydev' },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
				},
			},

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- See the fuzzy documentation for more information
			fuzzy = { implementation = "prefer_rust_with_warning" }
		},
		opts_extend = { "sources.default" }
	},

}
