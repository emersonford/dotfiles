lua << EOF
require'lspconfig'.pyls.setup{}
EOF

let b:delimitMate_nesting_quotes = ['"']
