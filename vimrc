" -------------------------------
"         Custom .vimrc
"         2017 wtty-fool
" -------------------------------


" -------------------------------
"     Vundle plugin manager
" -------------------------------
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'       " required!
Plugin 'morhetz/gruvbox'            " color theme
Plugin 'Valloric/YouCompleteMe'     " autocomplete
Plugin 'bling/vim-airline'          " permanent statusline
Plugin 'majutsushi/tagbar'          " code explorer
Plugin 'scrooloose/nerdtree'        " directory explorer
Plugin 'airblade/vim-gitgutter'     " Git integration
Plugin 'junegunn/limelight.vim'     " focus writing & coding
Plugin 'junegunn/goyo.vim'          " focus writing
call vundle#end()


" -------------------------------
"   General vim settings
" -------------------------------
filetype plugin indent on
set autoindent          " auto indentation
set autoread            " autoload files changed in the background
set cindent             " auto indentation for C files
set diffopt+=vertical   " vertical diff
set expandtab           " required so that you can use :ret to retab file
set list listchars=tab:»·,trail:·,nbsp:·    " trailing char markers
set nojoinspaces        " single spaces only on line join
set noswapfile          " no .swp file created during edition
set number              " enable line numbering
set numberwidth=5       " line no. column width
set relativenumber      " make line numbers relative to current line
set shiftround          " rounds indentation to x times <tab>
set shiftwidth=4        " <tab> width = 4 spaces
set splitbelow          " new splits appear on the bottom for :sp
set splitright          " and on the right for :vsp
set tabstop=4           " <tab> width = 4 spaces
" use Ctrl + H/J/K/L to navigate splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


" -------------------------------
"     Custom settings for
"     certain filetypes
" -------------------------------
autocmd FileType * autocmd BufWritePre <buffer> :%s/\s\+$//e   " remove trailing whitespace at save
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd FileType python setlocal textwidth=80


" -------------------------------
"     Individual plugin
"         settings
" -------------------------------
"
" Gruvbox
let g:gruvbox_italic = 1
let g:gruvbox_bold = 1
let g:gruvbox_contrast_dark = 'medium'
set bg=dark
silent! colorscheme gruvbox     " silent for the install run, when it's unavailable
"
" NERDTree
map <F7> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"
" TagBar
nmap <F8> :TagbarToggle<CR>
"
" LimeLight
let g:limelight_conceal_ctermfg = 245
"
" YouCompleteMe
nmap <F9> :YcmCompleter GoTo<CR>


" -------------------------------
"         End of .vimrc
" -------------------------------

