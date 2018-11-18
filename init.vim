" Enable syntax highlighting
syntax on
" ???
set nocompatible

if &shell == "/usr/bin/sudosh"
  set shell=/bin/bash
endif

call plug#begin('~/.config/nvim/plugged')

" File navigation
Plug 'ctrlpvim/ctrlp.vim', {'commit': '31b3aca71a626cae116b7ecd3e5ceb3f7bddb5a6'}
Plug 'scrooloose/nerdtree', {'tag': '5.0.0'}

" Programming languages
Plug 'elixir-lang/vim-elixir', {'commit': '1cfd5ab992b61bc30041950641eb577066269ee5'}
Plug 'vim-erlang/vim-erlang-runtime', {'commit': 'bafee7c69b23cc2923fda9ac16d6f83433645f30'}
Plug 'pangloss/vim-javascript', {'commit': '1d8c2677d26d6b3950b90dc1636e63334c8efc3b'}
Plug 'jtratner/vim-flavored-markdown', {'commit': '4a70aa2e0b98d20940a65ac38b6e9acc69c6b7a0'}
Plug 'vim-ruby/vim-ruby', {'commit': '666adb5bcdfb2d21572a58fcdf7545a26bac32a0'}

" Comment lines of code. Select text and gc
Plug 'tomtom/tcomment_vim', {'tag': '3.08'}

" Automatically add end characters ex. when you type if something do .... it
" adds an end
Plug 'tpope/vim-endwise', {'commit': '0067ceda37725d01b7bd5bf249d63b1b5d4e2ab4', 'for': ['ruby']}

" Git helpers
Plug 'tpope/vim-fugitive', {'commit': '008b9570860f552534109b4f618cf2ddd145eeb4'}

" Syntax checker
Plug 'vim-syntastic/syntastic', {'tag': 'v0.5.7'}

" Project-wide search and replace
Plug 'brooth/far.vim'

" Code navigation for starscope
Plug 'Shougo/unite.vim'
Plug 'devjoe/vim-codequery'

call plug#end()

" Syntax highlighting for ejs
" https://stackoverflow.com/questions/4597721/syntax-highlight-for-ejs-files-in-vim
au BufNewFile,BufRead *.ejs set filetype=html

"
" Vim Settings
"
" Tab size
set tabstop=2
" Enable line numbers
set number
" Change mapleader
let mapleader=","
" Map : to ;
nnoremap ; :
" Save all the swap information in one file
set noswapfile
" Automatically indent on new lines
set autoindent
" Copy the indentation of the previous line if auto indent doesn't know what to do
set copyindent
" Indenting a line with >> or << will indent or un-indent by 2
set shiftwidth=2
" Pressing tab in insert mode will use 4 spaces
set softtabstop=2
" Use spaces instead of tabs
set expandtab
" Disable mouse click to go to position
set mouse-=a
" Highlight the current line
set cursorline
" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list
" [SEARCH]
" The Vim editor will start searching when you type the first character of the
" search string. As you type in more characters, the search is refined.
:set incsearch
" Turn on search higlighting
set hlsearch
" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>
" Allow opnening a new file when the current buffer has unsaved changes
" without showing the "E37: No write since last change (add ! to override)
set hidden
" Make the cursor jump to the matching brace when a brace is inserted
set showmatch
set background=dark
" Make backspace work over line breaks. Auto-delete indentation.
" Delete past where insert mode started
set backspace=indent,eol,start
" Enable the ruler
set ruler
" Enable word wrap
set wrap
" Store the vim backups in .vim-backup in the current folder
" or the /tmp folder if that is not possible
set dir=./.vim-backup,/tmp
" Number of screen lines to keep above and below the cursor.
" This will make some context visible around the cursor
set scrolloff=5
" Make search case sensitive if it contains an upper case letter
" ignorecase makes case insensitive. smart case does the above.
set ignorecase
set smartcase
" Do not open these files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.rdb,*.pyc
" ESC exits terminal
tnoremap <Esc> <C-\><C-n>
" Use github markdown
autocmd BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
" Automatically clean up whitespace
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
map <silent> <LocalLeader>ws :highlight clear ExtraWhitespace<CR>
" Undo settings
set undodir=~/.config/nvim/undodir
set undofile
set undoreload=10000
" Key Mappings
" <Leader>CC comments the selected lines
map <silent> <LocalLeader>cc :TComment<CR>
" Run the current file with ruby
map <LocalLeader>tt :!bundle exec ruby %<CR>
" Search the 'app' folder in the project for the word under cursor
map <LocalLeader>ss :F <C-R><C-W> app/**/*<CR>
" Search the entire project folder for the word under cursor.
" This can take a while if there is a node_modules folder present
map <LocalLeader>sa :F <C-R><C-W> ./**/*<CR>
" Colors
if &t_Co == 256
  colorscheme jellybeans
endif
" Status Bar
set laststatus=2
set statusline=
set statusline+=%<\                       " cut at start
set statusline+=%2*[%n%H%M%R%W]%*\        " buffer number, and flags
set statusline+=%-40f\                    " relative path
set statusline+=%=                        " seperate between right- and left-aligned
set statusline+=%1*%y%*%*\                " file type
set statusline+=%10(L(%l/%L)%)\           " line
set statusline+=%2(C(%v)%)\           " column
set statusline+=%P                        " percentage of file


"
" Plugin Settings
"

" vim-ruby
" Configure autocomplete
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1

" Ctrl-P
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](node_modules|bower_components|rel|cordova|tmp|\.git|\.tmp|log|source_maps|deps|_build)$',
  \ 'file': '\v[\/].(gif|ico|jpg|png|zip|eot|ttf|svg)$',
  \ 'link': ''
  \ }

" NERDTree
" Open nerdtree on startup if no file was specified
" autocmd vimenter * if !argc() | NERDTree | endif
" Set up nerdtree shortcut: Ctrl + Shift + K
map <C-S-k> :NERDTreeToggle<CR>
" Close vim if the only open window is nerdtree
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" Close nt after opening a file
let NERDTreeQuitOnOpen = 1
let NERDTreeIgnore=['\.exc$', '\.pyc$', '\.o$', '\.class$']
" Show hidden files
let NERDTreeShowHidden=1

" Window zooming - zooms vertically and horizontally
" Use <C-w>= to go back to equal splits
nnoremap <C-w>o <C-w><bar><C-w>_

" Syntastic
" Recommended syntastic settings
set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" Make sytastic use eslint config files for linting
let g:syntastic_javascript_checkers = ['eslint']
" Use the project-specific binary of eslint
let g:syntastic_javascript_eslint_exe='$(npm bin)/eslint'
" Automatically format on save
" autocmd bufwritepost *.js silent !standard --fix %
" autocmd bufwritepost *.jsx silent !standard --fix %
" Sytastic autofix
" let g:syntastic_javascript_eslint_args = ['--fix']
" " enable autoread to reload any files from files when checktime is called and
" " the file is changed
" set autoread

" CodeQuery
" Search for method definitions
" nnoremap <space>s :CodeQuery Symbol<CR>
" nnoremap <space>d :CodeQuery Definition<CR>
" nnoremap <space>c :CodeQuery Caller<CR>
