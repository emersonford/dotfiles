" Disable vim-polyglot for Latex for vimtex
let g:polyglot_disabled = ['latex']

let g:tex_flavor='latex'
let g:vimtex_view_method='skim'
let g:vimtex_quickfix_mode=0
set conceallevel=2
let g:tex_conceal='abdmg'
let g:ale_fixers['tex'] = ["latexindent"] + g:ale_fixers['*']
let g:ale_tex_latexindent_options = "-y=\"defaultIndent:' '\""
let g:ale_linters['tex'] = ['texlab', 'chktex', 'lacheck']

" Enable ultisnips plugin for Latex
packadd ultisnips
