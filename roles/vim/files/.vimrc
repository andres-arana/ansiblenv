" *****************************************************************************
" VIM PLUGIN BUNDLES
" *****************************************************************************
call plug#begin('~/.vim/plugged')

" *****************************************************************************
" General utilities
" *****************************************************************************
" Fast asynchronous invocations
Plug 'Shougo/vimproc', {'do': 'make'}
" Colorscheme
Plug 'altercation/vim-colors-solarized'
" Powerfull status line
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Project explorer
Plug 'scrooloose/nerdtree'
" Repeat complex commands with .
Plug 'tpope/vim-repeat'
" Syntax checking on save
Plug 'scrooloose/syntastic'
" Paired mappings
Plug 'tpope/vim-unimpaired'
" Easy tmux navigation
Plug 'christoomey/vim-tmux-navigator'
" Vim dispatcher
Plug 'benmills/vimux'
" *****************************************************************************
" Unite
" *****************************************************************************
" Unite itself
Plug 'Shougo/unite.vim'
" Source for commandline and yank history
Plug 'thinca/vim-unite-history'
" Source for file outline
Plug 'Shougo/unite-outline'
" *****************************************************************************
" Text editing
" *****************************************************************************
" Comment and uncomment code
Plug 'tpope/vim-commentary'
" Surround expressions
Plug 'tpope/vim-surround'
" Tabular data edition
Plug 'godlygeek/tabular'
" Completions
Plug 'Valloric/YouCompleteMe', {'do': './install.py'}
" *****************************************************************************
" Navigation
" *****************************************************************************
" Text objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
" Improved % navigation matching
Plug 'vim-scripts/matchit.zip'
" Match HTML tags in % navigation
Plug 'gregsexton/MatchTag', {'autoload':{'filetypes':['html','xml']}}
" Quick mark navigation
Plug 'kshenoy/vim-signature'
" *****************************************************************************
" Views and templates
" *****************************************************************************
" Advanced css syntax
Plug 'JulesWang/css.vim'
" LESS syntax
Plug 'genoma/vim-less'
" SCSS syntax
Plug 'cakebaker/scss-syntax.vim'
" HTML5 syntax
Plug 'othree/html5.vim'
" Fast expansion for html tags
Plug 'mattn/emmet-vim'
" SLIM templates
Plug 'slim-template/vim-slim'
" *****************************************************************************
" Javascript development
" *****************************************************************************
" Additional javascript syntax
Plug 'pangloss/vim-javascript'
" Coffeescript syntax
Plug 'kchmck/vim-coffee-script'
" Livescript syntax
Plug 'gkz/vim-ls'
" Detect node shebang to set ft to javascript
Plug 'mmalecki/vim-node.js'
" JSON syntax
Plug 'leshill/vim-json'
" *****************************************************************************
" Ruby development
" *****************************************************************************
" Ruby syntax highlighting and other goodies
Plug 'vim-ruby/vim-ruby'
" Rails integration
Plug 'tpope/vim-rails'
" Smart scope delimiters
Plug 'tpope/vim-endwise'
" *****************************************************************************
" Clojure development
" *****************************************************************************
" REPL integration
Plug 'tpope/vim-fireplace'
" Augmentable clojure syntax
Plug 'guns/vim-clojure-static'
" REPL syntax highlighting
Plug 'guns/vim-clojure-highlight'
" SEXP editing
Plug 'guns/vim-sexp'
" SEXP mappings
Plug 'tpope/vim-sexp-mappings-for-regular-people'
" *****************************************************************************
" SCM integrations
" *****************************************************************************
" Fugitive
Plug 'tpope/vim-fugitive'

call plug#end()

" *****************************************************************************
" PLUGIN SETTINGS
" *****************************************************************************
let g:plug_timeout=900
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:airline_left_sep=''
let g:airline_right_sep=''
let NERDTreeMinimalUI=1
let NERDTreeMapJumpNextSibling=''
let NERDTreeMapJumpPrevSibling=''
let NERDTreeAutoDeleteBuffer=0
let NERDTreeCascadeOpenSingleChildDir=0
let NERDTreeBookmarksFile=expand("$HOME/.vim/bookmarks")
let g:syntastic_loc_list_height = 5
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '-i --vimgrep --hidden --ignore  .hg --ignore .svn --ignore .git --ignore .bzr --ignore node_modules'
let g:unite_source_grep_recursive_opt = ''
let g:solarized_termtrans = 1

" *****************************************************************************
" LEADER MAPPINGS
" *****************************************************************************
" Directory navigation
nnoremap <leader>de :e .<cr>
nnoremap <leader>ds :sp .<cr>
nnoremap <leader>dv :vsp .<cr>
nnoremap <leader>dt :tabedit .<cr>
" Quick config file edition
nnoremap <leader>cr :so $MYVIMRC<cr>
nnoremap <leader>ce :tabedit $MYVIMRC<cr>
" Unite
nnoremap <leader>uf :Unite -start-insert file_rec/async:!<cr>
nnoremap <leader>uj :Unite -start-insert jump<cr>
nnoremap <leader>ub :Unite -start-insert buffer<cr>
nnoremap <leader>ug :Unite -start-insert grep:.<cr>
nnoremap <leader>ut :Unite -start-insert tab<cr>
nnoremap <leader>uc :Unite -start-insert history/command<cr>
nnoremap <leader>us :Unite -start-insert history/search<cr>
nnoremap <leader>ur :Unite register<cr>
nnoremap <leader>uo :Unite -start-insert outline<cr>
" Vimux
nnoremap <leader>vp :VimuxPromptCommand<cr>
nnoremap <leader>vx :VimuxInterruptRunner<cr>
nnoremap <leader>vc :VimuxCloseRunner<cr>
nnoremap <leader>vz :VimuxZoomRunner<cr>
nnoremap <leader>vi :VimuxInspectRunner<cr>
nnoremap <leader>vl :VimuxRunLastCommand<cr>
nnoremap <leader>vv :VimuxRunCommand('vagrant up && vagrant ssh -c "cd /vagrant; bash"')<cr>

" *****************************************************************************
" STANDARD VIM SETTINGS
" *****************************************************************************
" Allow backspacing over everything in insert mode
set backspace=indent,eol,start
" Show line numbers
set number
set relativenumber
" Display tabs and trailing spaces
set list
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅
" Search options
set incsearch
set smartcase
" Line wrapping
set wrap
set linebreak
" Turn off swap file, backups and other inconvenient files
set noswapfile
set nobackup
set nowb
" Undo settings
set undodir=~/.vim/undofiles
set undofile
" INfo file
set viminfo+=n~/.vim/viminfo
" Default indent settings
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
" Folding settings
set foldmethod=indent
set foldnestmax=3
set nofoldenable
" Wild list
set wildmode=list:longest
set wildmenu
set wildignore=*.o,*.obj,*~
" Vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1
" Load ftplugins and indent files
filetype plugin indent on
" Turn on syntax highlighting
syntax on
" Hide buffers when not displayed
set hidden
" Allow visual block mode on empty chars
set virtualedit=block
" Set unicode encoding
set encoding=utf-8
" Always display the status line
set laststatus=2
" Enable the cursorline
set cursorline
set cursorcolumn
" *****************************************************************************
" STANDARD VIM MAPPINGS
" *****************************************************************************
" Use space as a leader alias
map <space> <leader>
" Fast esc
inoremap <C-c> <esc>
" Remove annoying mappings
nnoremap <F1> <nop>
nnoremap K <nop>
" Fast macros
nnoremap Q @q
" Fast formatting
nmap <leader>ff ggVG=<cr>
nmap <leader>f$ :%s/\s*$//g<cr>
" Make Y consistent
nnoremap Y y$
" Visual indent does not exit visual mode
vnoremap < <gv
vnoremap > >gv
" *****************************************************************************
" COLORSCHEME
" *****************************************************************************
set go=
set gfn=Inconsolata\ 10
set t_Co=16
set background=dark
colorscheme solarized
highligh clear SignColumn
