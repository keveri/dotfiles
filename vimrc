" no vi compatibility
set nocompatible

" enable syntax highlighting
syntax enable

" without this vim emits a zero exit status, later, because of :ft off
filetype on
filetype off

filetype plugin indent on

" no temporary files
set nobackup
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

set wildignore+=.git/**,build/**,dist/**,log/**,target/**
set wildignore+=*.so,*.dll,*.o,*.a,*.obj,*.exe,*.pyc,*.class
set wildignore+=.git,.hg,.svn
set wildignore+=*.bak,*.swp,.DS_Store,*.tmp,*~
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

set novisualbell " disable visual bells
set noerrorbells " disable error bells

set scrolloff=5 " show context above/below cursorline
set cursorline " highlight the current line
set laststatus=2 " always display the status line
set ruler " show the cursor position all the time
set number " show line numbers
set showcmd " display incomplete commands
set colorcolumn=80 " show color on this column
set mousehide " Hide mouse pointer while typing

set list " show trailing whitespace
set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣,trail:·
set showbreak=↪

set autoindent " copy indent from last line when starting new line
set smartindent
set wrap " wrap lines
set whichwrap+=<,>,h,l,[,] " wrap when used at beginning or end of lines

set autoread " reload files when changed on disk
set title " show the filename in the window titlebar
set ttyfast " optimize for fast terminal connections

set t_Co=256 " enable full-color support
set background=dark " use colors that look good on dark bg
colorscheme solarized8_dark
set encoding=utf8 nobomb " use UTF-8 without BOM

if has("termguicolors")
  set termguicolors
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

set splitbelow " new window goes below
set splitright " new window goes right

set backspace=indent,eol,start " allow backspace in insert mode

set history=1000 " increase history from default 20
set timeoutlen=1000 ttimeoutlen=0 " eliminate delays on ESC
set hidden " when a buffer is brought to foreground, remember undo history and marks


let mapleader="," " set leader key
" escape from jj
imap jj <Esc>
" easy macros
nnoremap <Space> @q
" treat long lines as break lines
map j gj
map k gk
nnoremap ; :
" quicker split movement
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
vnoremap < <gv
vnoremap > >gv
" select all
map <c-a> ggVG
" tab handling
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
" toggle spellcheck
map <leader>ss :setlocal spell!<cr>
" toggle highlighting on/off, and show current value.
:noremap <leader>h :set hlsearch! hlsearch?<CR>
" grep word under cursor
nnoremap <leader>g :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" search and replace word under cursor
nnoremap <leader>* :%s/\<<C-r><C-w>\>//<Left>
vnoremap <leader>* "hy:%s/\V<C-r>h//<left>
" remap :W to :w
command! W w
" Copy/paste
vnoremap <Leader>c "+y
nnoremap <Leader>v "+p
" Toggles
nnoremap <Leader>p :setl paste! paste?<cr>
nnoremap <Leader>n :set number!<cr>
nnoremap <leader>b :<c-u>exe "colors" (g:colors_name =~# "dark"
  \ ? substitute(g:colors_name, 'dark', 'light', '')
  \ : substitute(g:colors_name, 'light', 'dark', '')
  \ )<cr>


" Automatic commands
if has("autocmd")
  " Enable file type detection
  filetype on
  " Treat .json files as .js
  autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
  " Treat .md files as Markdown
  autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
  " highlight Custom C Types
  autocmd BufRead,BufNewFile *.[ch] let fname = expand('<afile>:p:h') . '/types.vim'
  autocmd BufRead,BufNewFile *.[ch] if filereadable(fname)
  autocmd BufRead,BufNewFile *.[ch]   exe 'so ' . fname
  autocmd BufRead,BufNewFile *.[ch] endif
endif


" local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
