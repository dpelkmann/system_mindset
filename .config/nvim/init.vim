"------------------------------------------------------------------------------
"- general settings
"------------------------------------------------------------------------------
:set number
:set relativenumber
:set expandtab
:set shiftwidth=4
:set tabstop=4
:set hidden
:set nospell " do not start with spell check
:set title
:set ignorecase " case insensitive search
:set smartcase
:set encoding=UTF-8
:set scrolloff=8
:set sidescrolloff=8

" style of spelling mistakes
hi clear SpellBad
hi clear SpellLocal
hi clear SpellRare
hi clear SpellCap
hi SpellBad cterm=underline ctermfg=203 guifg=#ff5f5f
hi SpellLocal cterm=underline ctermfg=203 guifg=#ff5f5f
hi SpellRare cterm=underline ctermfg=203 guifg=#ff5f5f
hi SpellCap cterm=underline ctermfg=203 guifg=#ff5f5f

" + nvim man open mode
" | arguments: horz, vert, tab
let g:ft_man_open_mode = "tab"

"------------------------------------------------------------------------------
"- key mappings 
"------------------------------------------------------------------------------
" change prefix key
let mapleader = "\<space>"

" + window management
" +--+ split (v)ertical or hori(z)ontal
map wv :vsplit <cr>
map wz :split <cr>
" +--+ move right
map wl :wincmd l <cr>
" +--+ move left
map wh :wincmd h <cr>
" +--+ move up
map wk :wincmd k <cr>
" +--+ move down
map wj :wincmd j <cr>
" +--+ close current window and keep buffer open
map wc :close <cr>
" +--+ close all other windows but leave all buffers open
map wo :only <cr>

" + buffer management
" +--+ move active buffer right
map bl :bn<cr>
map bk :bn<cr>
" +--+ move active buffer left
map bh :bp<cr>
map bj :bp<cr>
" +--+ delete active buffer and close current window
map bd :bd<cr>

" create file if gf says file does not exist
map <leader>gf :e <cfile><cr>
map gb :e# <cr> 

" open tig 
map <leader>tg :Tig<cr>

" toggle tagbar
map <leader>tb :Tagbar<cr>

" NERDCommenter
map <leader>cc <Plug>NERDCommenterNested
map <leader>ct <Plug>NERDCommenterToggle

" vimtex mappings (https://github.com/lervag/vimtex)
nmap <F4> :VimtexView<CR>
nmap <F5> :VimtexCompile<CR>
" tagbar mappings (https://github.com/preservim/tagbar/blob/master/doc/tagbar.txt)
nmap <F6> :TagbarToggle<CR>
nmap <F7> :TagbarOpen j<CR>
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" + Load Plugins with Plug
" | to install plugins: PlugInstall
" + brief help
" | :PluginList       - lists configured plugins
" | :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" | :PluginSearch foo - searches for foo; append `!` to refresh local cache
" | :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
call plug#begin(data_dir . '/plugins')
" + fzf - https://github.com/junegunn/fzf.vim
" | search for words and files
source ~/.config/nvim/plugins/fzf.vim
" + nightfox - https://github.com/EdenEast/nightfox.nvim
" | theme
source ~/.config/nvim/plugins/nightfox.vim
" + sonokai - https://github.com/sainnhe/sonokai
" | theme
source ~/.config/nvim/plugins/sonokai.vim
" + everforest - https://github.com/sainnhe/everforest
" | theme
source ~/.config/nvim/plugins/everforest.vim
" + nord - https://github.com/shaunsingh/nord.nvim
" | theme
source ~/.config/nvim/plugins/nord.vim
" + vscode.nvim - https://github.com/Mofiqul/vscode.nvim
" | theme
source ~/.config/nvim/plugins/vscode.vim
" + markdown-preview.nvim - https://github.com/iamcco/markdown-preview.nvim
" | interactive markdown preview in a browser 
source ~/.config/nvim/plugins/markdown-preview.vim
" + coc.vim - https://github.com/neoclide/coc.nvim
" | language server protocol server manager
" | !! A lot of languages are available. Each of them has it's own dependencies !!
source ~/.config/nvim/plugins/coc.vim
" + vim-airline - https://github.com/vim-airline/vim-airline
" | note: status and tab line bar for vim
source ~/.config/nvim/plugins/vim-airline.vim
" + vim-airline-themes - https://github.com/vim-airline/vim-airline
" | note: theme
source ~/.config/nvim/plugins/vim-airline-themes.vim
" + vim-fugitive - https://github.com/tpope/vim-fugitive
" | git integration for vim-airline
source ~/.config/nvim/plugins/vim-fugitive.vim
" + vim-heritage - https://github.com/jessarcher/vim-heritage
" | makes sure any parent directories exist when writing a new file (:e)
source ~/.config/nvim/plugins/vim-heritage.vim
" + nerdtree - https://github.com/preservim/nerdtree
" | the NERDTree is a file system explorer for the Vim editor
source ~/.config/nvim/plugins/nerdtree.vim
" + vim-nerdtree-syntax-highlight - https://github.com/tiagofumo/vim-nerdtree-syntax-highlight
" | his adds syntax for nerdtree on most common file extensions.
source ~/.config/nvim/plugins/vim-nerdtree-syntax-highlight.vim
" + rooter - https://github.com/airblade/vim-rooter
" | changes the working directory to the project root of opened file
source ~/.config/nvim/plugins/vim-rooter.vim
" + vim-sayonara - https://github.com/mhinz/vim-sayonara
" | plugin provides a single command that deletes the current buffer
source ~/.config/nvim/plugins/sayonara.vim
" + vim-devicons - https://github.com/ryanoasis/vim-devicons
" | adds filetype glyphs (icons) to various vim plugins
source ~/.config/nvim/plugins/vim-devicons.vim
" + vimtex - https://github.com/lervag/vimtex
" | add latex support to vim
source ~/.config/nvim/plugins/vimtex.vim
" + vim-tig - https://github.com/codeindulgence/vim-tig
" | add tig support to nvim
source ~/.config/nvim/plugins/vim-tig.vim
" + tagbar - https://github.com/preservim/tagbar
" | Tagbar is a Vim plugin that provides an easy way to browse the tags of the
" | current file and get an overview of its structure.
source ~/.config/nvim/plugins/tagbar.vim
" + NERD Commenter - https://github.com/preservim/nerdcommenter
" | out and in comment for lines
" | usage: [count]<leader>cc
source ~/.config/nvim/plugins/nerd-commenter.vim
" + indent blankline - https://github.com/lukas-reineke/indent-blankline.nvim
" | This plugin adds indentation guides to all lines (including empty lines).
source ~/.config/nvim/plugins/indent-blankline.vim

" hop
" telescope
" vim-smooth-scroll - https://github.com/terryma/vim-smooth-scroll
" targert.vim - https://github.com/wellle/targets.vim
" vim-which-key - https://github.com/liuchengxu/vim-which-key

call plug#end()

" -----------------------------------------------------------------------------
" - color schemes
" -----------------------------------------------------------------------------
" Info: load at the end because color scheme plugins have first to be loaded
" favorites: github_dark, nightfox, nordfox, sonokai:atlantis, everforest, vscode
colorscheme vscode 

doautocmd User PlugLoaded
