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
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'rstacruz/vim-closer'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-orgmode/orgmode'
Plug 'rust-lang/rust.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'andymass/vim-matchup'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-surround'
Plug 'szw/vim-maximizer'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'neovim/nvim-lspconfig'

call plug#end()

" rust-lang
syntax enable
filetype plugin indent on

" colorscheme
colorscheme tokyonight-moon

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

" quickly resize windows
nnoremap + <C-w>+
nnoremap - <C-w>-
nnoremap < <C-w><
nnoremap > <C-w>>

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

" Find files using Telescope command-line sugar.
nnoremap <leader>sf <cmd>Telescope find_files<cr>
nnoremap <leader>sg <cmd>Telescope live_grep<cr>
nnoremap <leader>sb <cmd>Telescope buffers<cr>
nnoremap <leader>sh <cmd>Telescope help_tags<cr>

" vim-maximizer
nnoremap <C-m> :MaximizerToggle<CR>

" }}}

" Vimscript file settings ---------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker 
augroup END
" }}}

" lua scripts for treesitter ---------------------- {{{
lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the four listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "help", "rust" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = true,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    --disable = function(lang, buf)
    --    local max_filesize = 100 * 1024 -- 100 KB
    --    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    --    if ok and stats and stats.size > max_filesize then
    --        return true
    --    end
    --end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF
" }}}

" lua scripts for org-mode ---------------------- {{{
lua << EOF
-- init.lua

-- Load custom treesitter grammar for org filetype
require('orgmode').setup_ts_grammar()

-- Treesitter configuration
require('nvim-treesitter.configs').setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop,
  -- highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    -- Required for spellcheck, some LaTex highlights and
    -- code block highlights that do not have ts grammar
    additional_vim_regex_highlighting = {'org'},
  },
  ensure_installed = {'org'}, -- Or run :TSUpdate org
}

require('orgmode').setup({
  org_agenda_files = {'~/org/*'},
  org_default_notes_file = '~/playground/org-test/refile.org',
})
EOF
" }}}

" lua scripts for telescope-fzf-native ---------------------- {{{
lua << EOF
-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
EOF
" }}}


" lua scripts for telescope-fzf-native ---------------------- {{{
lua << EOF
require'lspconfig'.pyright.setup{}
EOF
" }}}
