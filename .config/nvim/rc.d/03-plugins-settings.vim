" Colorscheme
set termguicolors
let g:onedark_terminal_italics = 1
colorscheme onedark

" Airline
let g:airline_theme = 'onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" Semantic-highlight.vim
autocmd FileType * :SemanticHighlight

" Vim-matchup
let g:loaded_matchit = 1
autocmd Filetype * hi MatchParen gui=italic

" Neoformat
nmap <silent> <leader>fc :Neoformat<CR>

" Vim-easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1  " Turn on case-insensitive feature
nmap s <Plug>(easymotion-overwin-f)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Vim-anyfold
autocmd Filetype * if &ft != "startify" | AnyFoldActivate  " Activate for all filetypes
set foldlevel=99  " Open all folds
