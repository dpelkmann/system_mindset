Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" + Highlight full name (not only icons)
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
" + Highlight folders using exact match 
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name
" you can add these colors to your .vimrc to help customizing
let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
let s:darkBlue = "44788E"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:beige = "F5C06F"
let s:yellow = "F09F17"
let s:orange = "D4843E"
let s:darkOrange = "F16529"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"
let s:config_red = 'FE405F'
let s:git_orange = 'F54D27'

" #############################################################################
" + Extension Highlight
let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
" +--+ css
let g:NERDTreeExtensionHighlightColor['css'] = s:blue " sets the color of css files to blue
" +--+ .conf
let g:NERDTreeExtensionHighlightColor['conf'] = s:config_red " sets the color for .gitignore files

" ###############################################################################
" Exact Math Highlight
let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
" +--+ .gitignore
let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange " sets the color for .gitignore files
" +--+ .gitconfig
let g:NERDTreeExactMatchHighlightColor['.gitconfig'] = s:git_orange " sets the color for .gitignore files

" #############################################################################
" + Pattern Highlight
let g:NERDTreePatternMatchHighlightColor = {} " this line is needed to avoid error
" +--+ .*spec.rb
let g:NERDTreePatternMatchHighlightColor['.*_spec\.rb$'] = s:config_red " sets the color for files ending with _spec.rb
" +--+ *rc
let g:NERDTreePatternMatchHighlightColor['.*rc$'] = s:config_red " sets the color for files ending with _spec.rb
" #############################################################################
" + Folder Color Settings
let g:WebDevIconsDefaultFolderSymbolColor = s:beige " sets the color for folders that did not match any rule
let g:WebDevIconsDefaultFileSymbolColor = s:blue " sets the color for files that did not match any rule


