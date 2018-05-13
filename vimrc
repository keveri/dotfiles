" SETTINGS

set nocompatible " no vi compatibility

filetype plugin indent on
syntax enable " enable syntax highlighting

set nobackup " no temporary files
set nowb
set noswapfile

set expandtab " expand tabs to spaces
set smarttab " smart handling of the <Tab> key
set shiftwidth=2 " normal mode indentation commands use 2 spaces
set softtabstop=2 " insert mode tab and backspace use 2 spaces
set tabstop=8 " actual tabs occupy 8 characters

set clipboard=unnamed " yank and paste with the system clipboard
if has("unnamedplus")
    set clipboard+=unnamedplus
endif 

set ofu=syntaxcomplete#Complete
set completeopt=menuone,longest,preview
set complete+=kspell " autocomplete with dictionary words when spell check is on

set wildmenu " show a navigable menu for tab completion
set wildmode=longest,list,full " complete only until point of ambiguity
set wildchar=<TAB> " Character for CLI expansion (TAB-completion)

set ignorecase " case-insensitive search
set smartcase " case-sensitive search if any caps
set magic " enable extended regexp
set showmatch " cursor will briefly jump to the new matching brace
set mat=2 " how many tenths of a second to blink when matching brackets
set hlsearch " highlight search matches
set incsearch " search as you type

set history=1000 " increase history from default 20
set timeoutlen=1000 ttimeoutlen=0 " eliminate delays on ESC

set autoread " reload files when changed on disk
set ttyfast " optimize for fast terminal connections

set encoding=utf8 nobomb " use UTF-8 without BOM

set hidden " when a buffer is brought to foreground, remember undo history and marks

set splitbelow " new window goes below
set splitright " new window goes right


" -----------------------------------------------------------------------------
" VISUAL

set novisualbell " disable visual bells
set noerrorbells " disable error bells

set scrolloff=5 " show context above/below cursorline
set cursorline " highlight the current line
set laststatus=2 " always display the status line
set ruler " show the cursor position all the time
set number " show line numbers
set showcmd " display incomplete commands
"set colorcolumn=80 " show color on this column
set mousehide " Hide mouse pointer while typing

set list " show trailing whitespace
set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣,trail:·
set showbreak=↪

set autoindent " copy indent from last line when starting new line
set smartindent
set wrap " wrap lines
set whichwrap+=<,>,h,l,[,] " wrap when used at beginning or end of lines

set title " show the filename in the window titlebar

set t_Co=256 " enable full-color support
set background=dark " use colors that look good on dark bg
colorscheme slate


" -----------------------------------------------------------------------------
" KEYS

set backspace=indent,eol,start " allow backspace in insert mode

let mapleader=","
nnoremap <Leader>p :setl paste! paste?<cr>
nnoremap <Leader>n :set number!<cr>
map <leader>ss :setlocal spell!<cr>
:noremap <leader>h :set hlsearch! hlsearch?<CR>
vnoremap <Leader>c "+y
nnoremap <Leader>v "+p

command! W w
imap jj <Esc>
nnoremap ; :

map j gj
map k gk


" -----------------------------------------------------------------------------
" OTHER

if has("autocmd")
  autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif


" local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
