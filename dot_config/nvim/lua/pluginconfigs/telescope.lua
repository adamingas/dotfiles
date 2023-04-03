local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

local vimtele = require('telescope').extensions.vimwiki
vim.keymap.set('n', '<leader>wf', vimtele.vimwiki, {})
vim.keymap.set('n', '<leader>wg', vimtele.live_grep, {})


