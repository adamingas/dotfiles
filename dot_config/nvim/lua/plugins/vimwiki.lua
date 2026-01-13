return { {
	'vimwiki/vimwiki',
	cmd = { "VimwikiIndex", "VimwikiDiaryIndex", "VimwikiMakeDiaryNote", "Telescope vimwiki" },

	keys = {
		{ "<leader>ww",         "<Plug>VimwikiIndex",            desc = "Vimwiki Index" },
		{ "<leader>wd",         "<Plug>VimwikiDiaryIndex",       desc = "Vimwiki Diary" },
		{ "<leader>w<leader>w", "<cmd>VimwikiMakeDiaryNote<CR>", desc = "Vimwiki Diary" },
		{ "<leader>d",          "<Plug>VimwikiToggleListItem",   desc = "Vimwiki toggle list item", mode = { "n", "v" } },
	},

	init = function()
		vim.api.nvim_create_autocmd("BufNewFile",
			{
				pattern = vim.fn.expand("~") .. "/vimwiki/diary/*.md",
				callback = function()
					vim.cmd("silent 0r !~/vimwiki/scripts/taskwiki_diary_template.py '%'")
				end,
			})
		vim.g.vimwiki_global_ext = 0
		vim.g.vimwiki_list = { { syntax = "markdown", path = "~/vimwiki", ext = ".md", links_space_char = "_", diary_frequency = "weekly" } }
	end
},
	{
		'tools-life/taskwiki',
		dependencies = { "vimwiki/vimwiki" },
		ft = { "vimwiki" }, -- only load in wiki buffers
		init = function()
			vim.g.taskwiki_suppress_mappings = "yes"
		end
	},
	{
		"mattn/calendar-vim",
		init = function()
			vim.g.calendar_week_start_day = 1
			vim.g.calendar_diary = vim.fn.expand("~/vimwiki/diary/")
		end
	}
}
