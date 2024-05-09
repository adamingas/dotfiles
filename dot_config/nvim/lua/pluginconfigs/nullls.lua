local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.completion.spell.with({filetypes={'markdown',"vimwiki"}}),
        -- null_ls.builtins.diagnostics.write_good.with({filetypes={'markdown',"vimwiki"},
        -- extra_args={"--no-passive"}}),
        null_ls.builtins.code_actions.proselint.with({filetypes={'markdown',"vimwiki","text"}})
    },
})

require("null-ls").setup({
    debug = false,
})

