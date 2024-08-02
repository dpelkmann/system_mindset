Plug 'vim-airline/vim-airline-themes'
" vim-airline - https://github.com/vim-airline/vim-airline
source ~/.config/nvim/plugins/vim-airline.vim
" default, powerlineish
lef g:airline_theme = 'dark'
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1

let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

set noshowmode
