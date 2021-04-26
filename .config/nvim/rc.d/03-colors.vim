" colorscheme
set termguicolors
let g:onedark_terminal_italics = 1
colorscheme onedark

" airline
let g:airline_theme = 'onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" rainbow
let g:rainbow_active = 1

" semantic-highlight.vim
autocmd FileType * :SemanticHighlight
