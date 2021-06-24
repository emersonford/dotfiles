let g:vimtex_view_method='skim'
let g:vimtex_view_automatic=1
let g:vimtex_quickfix_mode=0
" Let texlab handle completion.
let g:vimtex_complete_enabled=0
let g:vimtex_indent_enabled=0
let g:vimtex_syntax_enabled=0
let g:vimtex_fold_enabled=0

set conceallevel=2
let b:ale_fixers = ["latexindent"] + g:ale_fixers['*']
let b:ale_tex_latexindent_options = "-y=\"defaultIndent:' '\""

" augroup VimTeX
"     autocmd!
"     autocmd BufWritePost *.tex silent! call vimtex#compiler#compile()
" augroup END

" Enable ultisnips plugin for Latex
"packadd ultisnips
