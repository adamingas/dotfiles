return {
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = true
		-- use opts = {} for passing setup options
		-- this is equivalent to setup({}) function
	},
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		branch = 'main',
		build = ':TSUpdate',
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		main = "nvim-treesitter",
		init = function()
			local attempted = {}
			vim.api.nvim_create_autocmd('FileType', {
				desc = 'Enable Treesitter for all filetypes',
				pattern = { "python", "javascript", "typescript", "lua", "go", "rust", "java", "c", "cpp", "html", "css", "json", "yaml", "markdown", "terraform" },
				group = vim.api.nvim_create_augroup('ts-enable', { clear = true }),
				callback = function(args)
					local bufname = vim.api.nvim_buf_get_name(args.buf)
					local vimwiki_root = vim.fs.normalize(vim.fn.expand("~/vimwiki")) .. "/"
					if vim.startswith(bufname, vimwiki_root) then
						return
					end
					local filetype = vim.bo[args.buf].filetype
					local lang = vim.treesitter.language.get_lang(filetype)
					if not lang then
						return
					end
					if not attempted[lang] then
						attempted[lang] = true
						local ts = require("nvim-treesitter")
						if not vim.tbl_contains(ts.get_installed(), lang) then
							ts.install({ lang })
						end
					end
					pcall(vim.treesitter.start, args.buf, lang)

					if filetype == "markdown" then
						vim.opt_local.foldmethod = "expr"
						vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
						vim.opt_local.foldenable = true
						vim.opt_local.foldlevel = 99
					end
				end,
			})
		end,
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			textobjects = {
				select = {
					enable = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
			},
			rainbow = {
				enable = true,
				extended_mode = true,
				max_file_lines = nil,
			},
			context_commentstring = {
				enable = true,
				enable_autocmd = false,
			},
		}
	},
	{ "https://gitlab.com/HiPhish/rainbow-delimiters.nvim" },
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
	},
	{
		"stevearc/aerial.nvim",
		opts = {},
		config = function(opts)
			require("aerial").setup({
				disable_max_lines = 0,
				disable_max_size = 0,
				-- optionally use on_attach to set keymaps when aerial has attached to a buffer
				on_attach = function(bufnr)
					-- Jump forwards/backwards with '{' and '}'
					vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
					vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
				end,
			})
			-- You probably also want to set a keymap to toggle aerial
			vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
		end
		,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons"
		}
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		lazy = false,
		config = function(opts)
			require("treesitter-context").setup({})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		}
	}
}
