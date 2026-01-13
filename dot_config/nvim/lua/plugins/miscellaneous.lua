return {
    {'kassio/neoterm', 
    init=function()
	vim.g.neoterm_default_mod = ":belowright"
    end,
    keys={
	{"<C-`>", "<cmd>:Ttoggle<cr>", mode={"n","t"}, desc="Toggle terminal"}
    }
},
{
    "kylechui/nvim-surround",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
    -- event = "VeryLazy",
},
{"lewis6991/gitsigns.nvim"}
}
