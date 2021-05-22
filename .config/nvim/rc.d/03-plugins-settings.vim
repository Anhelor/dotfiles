" Colorscheme
set termguicolors
let g:onedark_terminal_italics = 1
colorscheme onedark

" Airline
let g:airline_theme = 'onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" Rainbow
let g:rainbow_active = 1

" Semantic-highlight.vim
autocmd FileType * :SemanticHighlight

" Vim-matchup
let g:loaded_matchit = 1

" Neoformat
nmap <silent> <leader>fc :Neoformat<CR>
