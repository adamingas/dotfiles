  return {
      {"github/copilot.vim",
	   init = function()
		   vim.g.copilot_filetypes = {
			   ["*"] = true,
			   ["markdown"] = false,
			   ["vimwiki"] = false,
			   ["text"] = false,
		   }
		   vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
	   end,
	  }
  }
