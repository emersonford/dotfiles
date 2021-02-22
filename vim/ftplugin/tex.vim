let b:vimtex_view_method='skim'
let b:vimtex_quickfix_mode=0
set conceallevel=2
let b:tex_conceal='abdmg'
let b:ale_fixers = ["latexindent"] + g:ale_fixers['*']
let b:ale_tex_latexindent_options = "-y=\"defaultIndent:' '\""
let b:ale_linters = ['texlab', 'chktex']
let b:ale_lsp_root = {'texlab': expand('%:p:h')}

" Enable ultisnips plugin for Latex
packadd ultisnips
