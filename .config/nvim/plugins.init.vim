call plug#begin('~/.config/nvim/plugged')

" Prettifying vim ============================================================
Plug 'ayu-theme/ayu-vim'                            " 'ayu' theme for vim
Plug 'itchyny/lightline.vim'                        " Lightline

" Better coding experience ===================================================
" Plug 'dense-analysis/ale'                           " Linting engine
" Plug 'maximbaz/lightline-ale'                       " Lightline + ALE
Plug 'neoclide/coc.nvim', {'branch': 'release'}     " Auto-completion
Plug 'tpope/vim-fugitive'                           " Git plugin
" Plug 'preservim/nerdtree'                           " File explorer
" Plug 'justinmk/vim-dirvish'                         " File explorer
" Plug 'kristijanhusak/vim-dirvish-git'               " Git plugin for dirvish
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzy find
Plug 'junegunn/fzf.vim'                             " Fuzzy find

" Language-specific plugins ==================================================
Plug 'fatih/vim-go'                                 " Golang
Plug 'rust-lang/rust.vim'                           " rust-lang
Plug 'cespare/vim-toml'                             " TOML

call plug#end()

" Configuration for 'ayu' ----------------------------------------------------
source ~/.config/nvim/colo.init.vim
" Configuration for 'coc' ----------------------------------------------------
source ~/.config/nvim/coc.init.vim
" Configuration for 'fzf' ----------------------------------------------------
source ~/.config/nvim/fzf.init.vim
" Configuration for file explorer --------------------------------------------
source ~/.config/nvim/navi.init.vim
" Configuration for 'lightline' ----------------------------------------------
source ~/.config/nvim/lightline.init.vim