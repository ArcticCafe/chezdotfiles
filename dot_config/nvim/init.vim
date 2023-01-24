set number
set hlsearch
set showmatch
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set autoindent
set clipboard=unnamedplus
set cursorline
set shiftround
set switchbuf+=usetab,newtab

let mapleader = " "
" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'mhinz/vim-startify'
Plug 'myusuf3/numbers.vim'
Plug 'preservim/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rstacruz/vim-closer'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jceb/vim-orgmode'
Plug 'rust-lang/rust.vim'

call plug#end()

" rust-lang
syntax enable
filetype plugin indent on

" Chinese character
set fileencodings=utf8,cp936,gb18030,big5

" nerdtree settings
nnoremap <leader>t :NERDTreeToggle<CR>


" copy to the clipboard
set clipboard=

" change the air-line-theme
let g:airline_theme='deus'

" mappings ---------------------- {{{
" focus movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" disable highlight search
nnoremap <leader>n :set hlsearch!<CR>

" Move to the begin/end of the line
nnoremap H 0
nnoremap L $
nnoremap J L
nnoremap K H


" map <Esc> to exit terminal-mode
:tnoremap jk <C-\><C-n>

" edit vim config
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>es :source $MYVIMRC<CR>

nnoremap <leader>i :PlugInstall<CR> " install the plugins
nnoremap <leader>m :MarkdownPreview<CR>
nnoremap <leader>s :MarkdownPreviewStop<CR>

" fzf
"let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
nnoremap <leader>o :FZF<CR>
nnoremap <leader>g :Ag 

" jk to normal mode
inoremap jk <Esc>

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" <c-d> to delete a line
inoremap <C-d> <Esc>ddi

" vim grep word

" }}}

" Vimscript file settings ---------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker 
augroup END
" }}}
