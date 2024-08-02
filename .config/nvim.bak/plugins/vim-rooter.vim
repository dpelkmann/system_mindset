Plug 'airblade/vim-rooter'
" How to Identify a Root Directory
" source: https://github.com/airblade/vim-rooter#configuration
" 1. specify the root is a certain directory, prefix it with =
" 2. specify the root has a certain directory or file (which may be a glob)
" 3. specify the root has a certain directory as its direct ancestor / parent (useful when you put working projects in a common directory), prefix it with >
let g:rooter_patterns = ['.git', '.bashrc', '=.config']
