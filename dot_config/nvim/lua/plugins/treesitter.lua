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
		build = ':TSUpdate'
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
		depedencies = {
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
		depedencies = {
			"nvim-treesitter/nvim-treesitter",
		}
	}
}
