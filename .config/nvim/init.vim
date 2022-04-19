"------------------------------------------------------------------------------
"- general settings
"------------------------------------------------------------------------------
:set expandtab
:set shiftwidth=4
:set tabstop=4
:set hidden
:set number
:set relativenumber
:set nospell " do not start with spell check
:set title
:set ignorecase " case insensitive search
:set smartcase
:set encoding=UTF-8

" style of spelling mistakes
hi clear SpellBad
hi clear SpellLocal
hi clear SpellRare
hi clear SpellCap
hi SpellBad cterm=underline ctermfg=203 guifg=#ff5f5f
hi SpellLocal cterm=underline ctermfg=203 guifg=#ff5f5f
hi SpellRare cterm=underline ctermfg=203 guifg=#ff5f5f
hi SpellCap cterm=underline ctermfg=203 guifg=#ff5f5f

"------------------------------------------------------------------------------
"- key mappings 
"------------------------------------------------------------------------------
" change prefix key
let mapleader = "\<space>"

" buffer management
map bn :bn<cr>
map bp :bp<cr>
map bd :bd<cr>

" create file if gf says file does not exist
:map <leader>gf :e <cfile><cr>

" search informations
" Note: after a search (?"search term"<CR>) n: for next, shft+n for previous
" Note: search and replace all: ?%s/"word to replace"/"replace term"/g
" Note: when in global mode # on a word will highlight all other words 
map <F8> :setlocal nohlsearch<CR> " toggle nohlsearch 
" toggle English spell check
map <F9> :setlocal spell! spelllang=en_us<CR>
" toggle German spell check
map <F10> :setlocal spell! spelllang=de_de<CR>

" -----------------------------------------------------------------------------
" - plugins
" -----------------------------------------------------------------------------
" automatically install vim-plug
" source: https://github.com/jessarcher/dotfiles/blob/54de5d495366e5f8caa739f4a7cccea45aab3b55/nvim/init.vim
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" load plugins
" | to install plugins: PlugInstall
call plug#begin(data_dir . '/plugins')

" fzf - https://github.com/junegunn/fzf.vim
" note: search for words and files
source ~/.config/nvim/plugins/fzf.vim
" nightfox - https://github.com/EdenEast/nightfox.nvim
" note: theme
source ~/.config/nvim/plugins/nightfox.vim
" sonokai - https://github.com/sainnhe/sonokai
" note: theme
source ~/.config/nvim/plugins/sonokai.vim
" everforest - https://github.com/sainnhe/everforest
" note: theme
source ~/.config/nvim/plugins/everforest.vim
" nord - https://github.com/shaunsingh/nord.nvim
" note: theme
source ~/.config/nvim/plugins/nord.vim
" vscode.nvim - https://github.com/Mofiqul/vscode.nvim
" note: theme
source ~/.config/nvim/plugins/vscode.vim
" markdown-preview.nvim - https://github.com/iamcco/markdown-preview.nvim
" note: interactive markdown preview in a browser 
source ~/.config/nvim/plugins/markdown-preview.vim
" coc.vim - https://github.com/neoclide/coc.nvim
" note: language server protocol server manager
" !! A lot of languages are available. Each of them has it's own dependencies !!
source ~/.config/nvim/plugins/coc.vim
" vim-airline - https://github.com/vim-airline/vim-airline
" note: status and tab line bar for vim
source ~/.config/nvim/plugins/vim-airline.vim
" vim-airline-themes - https://github.com/vim-airline/vim-airline
" note: theme
source ~/.config/nvim/plugins/vim-airline-themes.vim
" vim-fugitive - https://github.com/tpope/vim-fugitive
" note: git integration for vim-airline
source ~/.config/nvim/plugins/vim-fugitive.vim
" vim-heritage - https://github.com/jessarcher/vim-heritage
" note: makes sure any parent directories exist when writing a new file (:e)
source ~/.config/nvim/plugins/vim-heritage.vim
" nerdtree - https://github.com/preservim/nerdtree
" note: the NERDTree is a file system explorer for the Vim editor
source ~/.config/nvim/plugins/nerdtree.vim
" rooter - https://github.com/airblade/vim-rooter
" note: changes the working directory to the project root of opened file
source ~/.config/nvim/plugins/vim-rooter.vim
" vim-sayonara - https://github.com/mhinz/vim-sayonara
" note: plugin provides a single command that deletes the current buffer
source ~/.config/nvim/plugins/sayonara.vim
" vim-devicons - https://github.com/ryanoasis/vim-devicons
" note: Adds filetype glyphs (icons) to various vim plugins
source ~/.config/nvim/plugins/vim-devicons.vim

" vim-smooth-scroll - https://github.com/terryma/vim-smooth-scroll
" targert.vim - https://github.com/wellle/targets.vim
" vim-which-key - https://github.com/liuchengxu/vim-which-key

" Latex workflow?

call plug#end()

" -----------------------------------------------------------------------------
" - color schemes
" -----------------------------------------------------------------------------
" Info: load at the end because color scheme plugins have first to be loaded
" favorites: github_dark, nightfox, nordfox, sonokai:atlantis, everforest, vscode
colorscheme vscode 

doautocmd User PlugLoaded
