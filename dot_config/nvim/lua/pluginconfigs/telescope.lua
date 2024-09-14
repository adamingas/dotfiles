local builtin = require('telescope.builtin')
local telescope = require("telescope")
telescope.load_extension("aerial")

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fs', builtin.lsp_dynamic_workspace_symbols, {})
vim.keymap.set('n', '<leader>fs', telescope.extensions.aerial.aerial, {})

vim.keymap.set('n', '<leader>lf', function() builtin.find_files({ search_dirs ={'~/.config/nvim'}}) end, {})
vim.keymap.set('n', '<leader>lg', function() builtin.live_grep({ search_dirs ={'~/.config/nvim'}}) end, {})

local vimtele = require('telescope').extensions.vimwiki
vim.keymap.set('n', '<leader>wf', vimtele.vimwiki, {})
vim.keymap.set('n', '<leader>wg', vimtele.live_grep, {})

telescope.setup({
  mappings = {
        n = {
             ["<C-d>"] = require('telescope.actions').delete_buffer
        }
    },
  extensions = {
    aerial = {
      -- Display symbols as <root>.<parent>.<symbol>
      show_nesting = {
        ["_"] = false, -- This key will be the default
        json = true, -- You can set the option for specific filetypes
        yaml = true,
      },
    },
  },
})
