let g:ale_fixers['go'] = ['gofmt'] + g:ale_fixers['*']
let g:ale_linters['go'] = ['gofmt', 'govet', 'golint', 'gopls']
