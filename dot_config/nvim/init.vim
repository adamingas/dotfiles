set syntax 
set nocompatible              " be iMproved, required
filetype plugin indent on    " required
let mapleader=' '
set mouse=a
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()
" set conceallevel=2


let $LUACONFIG='$HOME/.config/nvim/lua/config.lua'
let g:vimteractive_default_shells = { 'python': 'ipython' }
" let g:vimteractive_default_shells = { 'ipython': 'ipython3' }
let g:vimteractive_commands = { 'ipython': 'ipython3' }
let g:vimteractive_bracketed_paste_default = 0
let g:neoterm_default_mod='botright'


let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
" Plug 'williamjameshandley/vimteractive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-lua/plenary.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp' " Autocompletion plugin
Plug 'hrsh7th/cmp-nvim-lsp' " LSP source for nvim-cmp
Plug 'saadparwaiz1/cmp_luasnip' " Snippets source for nvim-cmp
Plug 'L3MON4D3/LuaSnip' " Snippets plugin
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'rafamadriz/friendly-snippets'
Plug 'kassio/neoterm'
Plug 'nvim-treesitter/playground'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
Plug 'ElPiloto/telescope-vimwiki.nvim'

" Plug 'lervag/wiki.vim'
Plug 'mattn/calendar-vim'
Plug 'Mofiqul/vscode.nvim'
Plug 'p00f/nvim-ts-rainbow'
Plug 'rafamadriz/neon' 
Plug 'tomasiser/vim-code-dark'
Plug 'preservim/vim-markdown'
Plug 'vimwiki/vimwiki', { 'branch': 'dev'}
Plug 'justinmk/vim-sneak'
call plug#end()

"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
"" alternatively, pass a path where Vundle should install plugins
""call vundle#begin('~/some/path/here')

"" let Vundle manage Vundle, required
"Plugin 'VundleVim/Vundle.vim'
"" Plugin 'davidhalter/jedi-vim'
"Plugin 'williamjameshandley/vimteractive'
"Plugin 'tpope/vim-surround'
"Plugin 'tpope/vim-commentary'
"Plugin 'folke/tokyonight.nvim', { 'branch': 'main' }
"" Plugin 'ycm-core/YouCompleteMe'
"call vundle#end()            " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append  to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append  to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append  to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set termguicolors
set cursorline
set tabstop=4
set shiftwidth=4
set expandtab
set number
set number relativenumber
set splitbelow
set splitright
set signcolumn=yes
set updatetime=100

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

" Remaps
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" nnoremap <leader>W <C-W>
nnoremap <C-E> <C-W>
" nnoremap <Tab> gt
" nnoremap <S-Tab> gT
tnoremap <C-W> <C-\><C-N>
" <c -w> doesn't work through chrome terminal windows
nnoremap <C-E> <C-W>
nnoremap <silent> <Leader>h :nohl<cr><esc>
" nnoremap <silent> <Leader>w :w<cr><esc>
nnoremap  <Leader>s :w <bar> source $MYVIMRC <cr><esc>


nmap <C-S><C-S> <Plug>(neoterm-repl-send-line)
nmap <C-S> <Plug>(neoterm-repl-send)
imap <C-S><C-S> <Esc><Plug>(neoterm-repl-send-line)
vmap <C-S> <Plug>(neoterm-repl-send)

" Lua specific configs
" colorscheme tokyonight
let g:neon_style='dark'
let g:neon_transparent=0
let g:neon_italic_keyword=1
let g:neon_italic_function=1
" colorscheme tokyonight-dark
colorscheme codedark
" colorscheme vscode

" Loading in the config
lua require('config')

" Wiki config
" let g:calendar_diary='~/vimwiki/journal'
" g:calendar_action=
let g:markdown_folding = 1
let g:wiki_root = '~/vimwiki'

" vimwiki settings
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
nmap <leader>w<leader>h <Plug>VimwikiDiaryPrevDay`
nmap <leader>w<leader>l <Plug>VimwikiDiaryNextDay`
nmap <leader>d <Plug>VimwikiToggleListItem
vmap <leader>d <Plug>VimwikiToggleListItem
" Colors, this really should be in a different script but whatever
hi link VimwikiHeader1 htmlH1
hi link VimwikiHeader2 htmlH2
hi link VimwikiHeader3 htmlH3
let g:wiki_filetypes = ['md', 'wiki']