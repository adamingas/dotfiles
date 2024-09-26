setlocal commentstring=<!--%s-->
setlocal foldmethod=syntax
" function! Foldexpr_markdown(lnum)
"     if (a:lnum == 1)
"         let l0 = ''
"     else
"         let l0 = getline(a:lnum-1)
"     endif

"     " keep track of fenced code blocks
"     if l0 =~# '````*' || l0 =~# '\~\~\~\~*'
"         if b:fenced_block == 0
"             let b:fenced_block = 1
"         elseif b:fenced_block == 1
"             let b:fenced_block = 0
"         endif
"     elseif get(g:, 'vim_markdown_frontmatter', 0) == 1
"         if b:front_matter == 1
"             if l0 ==# '---'
"                 let b:front_matter = 0
"             endif
"         elseif a:lnum == 2
"             if l0 ==# '---'
"                 let b:front_matter = 1
"             endif
"         endif
"     endif

"     if b:fenced_block == 1 || b:front_matter == 1
"         " keep previous foldlevel
"         return '='
"     endif

"     let l2 = getline(a:lnum+1)
"     if  l2 =~# '^==\+\s*' && !s:is_mkdCode(a:lnum+1)
"         " next line is underlined (level 1)
"         return '>1'
"     elseif l2 =~# '^--\+\s*$' && !s:is_mkdCode(a:lnum+1)
"         " next line is underlined (level 2)
"         if s:vim_markdown_folding_level >= 2
"             return '>1'
"         else
"             return '>2'
"         endif
"     endif

"     let l1 = getline(a:lnum)
"     if l1 =~# '^#' && !s:is_mkdCode(a:lnum)
"         " fold level according to option
"         if s:vim_markdown_folding_level == 1 || matchend(l1, '^#\+') > s:vim_markdown_folding_level
"             if a:lnum == line('$')
"                 return matchend(l1, '^#\+') - 1
"             else
"                 return -1
"             endif
"         else
"             " headers are not folded
"             return 0
"         endif
"     endif

"     if l0 =~# '^#' && !s:is_mkdCode(a:lnum-1)
"         " previous line starts with hashes
"         return '>'.matchend(l0, '^#\+')
"     else
"         " keep previous foldlevel
"         return '='
"     endif
" endfunction

" setlocal foldexpr=Foldexpr_markdown(v:lnum)
