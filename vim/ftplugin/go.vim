" Go uses tabs for indents
set noexpandtab

let b:ale_fixers = ['gofmt'] + g:ale_fixers['*']
let b:ale_linters = ['gofmt', 'govet', 'golint', 'gopls']
