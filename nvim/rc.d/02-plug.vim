" Vim-plug
call plug#begin('~/.cache/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'morhetz/gruvbox'
Plug 'luochen1990/rainbow'
Plug 'mhinz/vim-startify'
Plug 'ryanoasis/vim-devicons'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'itchyny/vim-cursorword'
Plug 'ntpeters/vim-better-whitespace'
Plug 'chrisbra/vim-diff-enhanced'
Plug 'yianwillis/vimcdoc'
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'lilydjwg/fcitx.vim'

Plug 'ludovicchabant/vim-gutentags'
Plug 'liuchengxu/vista.vim'
Plug 'honza/vim-snippets'
Plug 'neoclide/coc.nvim'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'justinmk/vim-syntax-extra'
Plug 'sheerun/vim-polyglot'
Plug 'sbdchd/neoformat'
Plug 'Yggdroot/indentLine'
call plug#end()
