require('pluginconfigs.lspconfig')
require('pluginconfigs.aerial')
require('pluginconfigs.lualine')
require('pluginconfigs.telescope')
require('pluginconfigs.nvimcmp')
require('pluginconfigs.nullls')
require("nvim-autopairs").setup()
require('ibl').setup()

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "python", "lua"},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,
  ignore_install = {'markdown'},

  -- List of parsers to ignore installing (for "all")
  indent = {
    enable = true,
    disable = {'python'}
  },

  highlight = {
		  -- `false` will disable the whole extension
    enable = true,
    disable = {'markdown','markdown_inline'},

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>", -- set to `false` to disable one of the mappings
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
    playground = {
            enable = true,
            disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = 'o',
          toggle_hl_groups = 'i',
          toggle_injected_languages = 't',
          toggle_anonymous_nodes = 'a',
          toggle_language_display = 'I',
          focus_language = 'f',
          unfocus_language = 'F',
          update = 'R',
          goto_node = '<cr>',
          show_help = '?',
    }
    },
      rainbow = {
        enable = true,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
  }

}



-- copilot settings
vim.keymap.set('i', '<M-Down>', 'copilot#Accept("\\<CR>")', {
          expr = true,
          replace_keycodes = false
        })
vim.keymap.set('i', '<M-Tab>', 'copilot#Accept("\\<CR>")', {
          expr = true,
          replace_keycodes = false
        })
if vim.g.started_by_firenvim == true then
  vim.o.laststatus = 0
  vim.opt_local.spell = false
else
  vim.o.laststatus = 2
end
