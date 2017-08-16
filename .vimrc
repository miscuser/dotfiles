" Misc. vimrc

"-- Vundle
set nocompatible
filetype off

if !isdirectory(expand("~/.vim/bundle/Vundle.vim/.git"))
    !git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
endif

"-- Install my colors.
if !isdirectory(expand("~/.vim/colors"))
    !git clone https://github.com/miscuser/colors.git ~/.vim/colors
endif

"-- Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'         " Let Vundle manage Vundle
Plugin 'Lokaltog/vim-easymotion'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-surround'
Plugin 'ervandew/supertab'
Plugin 'kien/ctrlp.vim'
Plugin 'davidhalter/jedi-vim'
call vundle#end()                  " required
filetype plugin indent on          " required

"-- Basic settings
set clipboard=unnamed
source ~/dotfiles/abbreviations.vim   " common abbreviations
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set listchars=tab:▸\ ,eol:¬
set term=xterm-256color       " fancy colors
set nowrap                    " wrapping off
set textwidth=0
set history=1000              " keep a long command history
set undolevels=500            " allow a lot of undo activity
set ruler                     " show cursor position
set showcmd                   " display incomplete commands
set nostartofline             " do not reset cursor to start of line
set number                    " line numbers
set clipboard=unnamed         " default to system clipboard
set tabstop=4 shiftwidth=4 expandtab  " make tabs reasonable
set visualbell                " disable sounds
set noerrorbells              " disable beeps
set shortmess+=I              " disable welcome screen
set showmatch                 " show matching parentheses
let mapleader=","             " use comma as leader
set cursorline                " underline current line
set spellsuggest=10           " set number of spelling suggestions
set autoread                  " automatically update file when changed outside of vim
set matchpairs+=<:>           " match pairs beyond defaults
autocmd BufEnter * lcd %:p:h  " set current working directory to current buffer location
syntax on                     " syntax coloring

"-- Searching
set hlsearch                  " highlight search results
set incsearch                 " use incremental search
set ignorecase                " ignore case by default in search
set smartcase                 " smart case search (insensitive if all lowercase; sensitive otherwise)
nmap <silent> <leader>/ :nohlsearch<CR>
nmap s <Plug>(easymotion-s)
nmap t <Plug>(easymotion-s2)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
let g:EasyMotion_startofline = 0
" change the default search to easymotion
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
" Search for current word under cursor.
map <Leader>* :execute "vimgrep /\\<" . expand("<cword>") . "\\>/g **" <bar> cw <cr>
" go to line
map <Leader>g <Plug>(easymotion-bd-jk)
nmap <Leader>g <Plug>(easymotion-overwin-line)
" go to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

"-- Replace current visual selection. Uses register 'o'.
vnoremap <C-r> "oy:%s/<C-r>o//<left>

"-- Status line
set laststatus=2
set statusline=
set statusline+=%7*\[%n]                                  " buffer
set statusline+=%1*\ %<%F\                                " file+path
set statusline+=%2*\ %y\                                  " file type
set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      " encoding
set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            " encoding2
set statusline+=%4*\ %{&ff}\                              " file format
set statusline+=%8*\ %=\ row:%l/%L\ (%03p%%)\             " rownumber/total (%)
set statusline+=%9*\ col:%03c\                            " column
set statusline+=%0*\ \ %m%r%w\ %P\ \                      " Modified? Readonly? Top/bot.

"-- Folding
set nofoldenable              " don't fold by default
set foldmethod=indent         " fold based on indent
set foldnestmax=10            " deepest fold is 10 levels
set foldlevel=1

"-- Colorschemes
autocmd BufEnter *     colorscheme badwolf
autocmd BufEnter *.txt colorscheme murphy

"-- Buffers
noremap  <leader>be :enew<CR>
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" -- Quixfix window
" noremap <C-PageDown> :cnext<CR>
" noremap <C-PageUp> :cprev<CR>

"-- Split screens
set splitright                             " opens new splits to the right
nnoremap <C-h> <C-w>h                      " move left between splits
nnoremap <C-j> <C-w>j                      " move down between splits
nnoremap <C-k> <C-w>k                      " move up between splits
nnoremap <C-l> <C-w>l                      " move right between splits
nnoremap <A-down> :vertical resize -5<CR>  " decrease width
nnoremap <A-up> :vertical resize +5<CR>    " increase width
nnoremap <leader>v :vnew<CR><C-w>l         " open vertical split and switch to it
nnoremap <leader>h :new<CR><C-w>k          " open horizontal split and switch to it

"-- Make changing tabs easier.
nnoremap <C-PageUp> :tabprevious<CR>
nnoremap <C-PageDown> :tabnext<CR>

"-- Copy, highlight, and navigation
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%200v.\+/

"-- Encoding
set termencoding=utf-8
set encoding=utf-8

"-- Pandoc and markdown
au BufRead,BufNewFile,BufEnter *.md,*.markdown set filetype=markdown  " set filetypes
command PDF ! pandoc -V geometry:margin=1in % -o %:r.pdf
map <silent> <leader>mp :PDF<CR>

"-- Open common files
map <silent> <leader>ev :e $MYVIMRC<CR>                       " vimrc
nmap <silent> <leader>sv :so $MYVIMRC<CR>                     " source vimrc
map <silent> <leader>eb :e ~/dotfiles/.bashrc<CR>             " bashrc
map <silent> <leader>et :e ~/dotfiles/.tmux.conf<CR>          " tmux 

"-- Sanity mappings
nnoremap ; :
nnoremap j gj
nnoremap k gk
inoremap jj <ESC>
map Q <nop>

"-- Backups
set nobackup
set noswapfile

if has('persistent_undo')
    set undodir=~/.vim/tmp/undo//     " undo files
    if !isdirectory(expand(&undodir))
        call mkdir(expand(&undodir), "p")
    endif
endif

set backupdir=~/.vim/tmp/backup//   " backups
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif

set directory=~/.vim/tmp/swap       " swap files
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

"-- Scrolling
set scrolloff=5         " show context above/below cursor line
set sidescrolloff=10    " number of cols from horizontal edge to  start scrolling
set sidescroll=1        " number of cols to scroll at a time

"-- Misc. mappings
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>     " strip whitespace from the end of lines
nmap <leader>z z=                                    " show suggested spelling
map <leader>i :set list!<CR>                         " toggle listchars on/off
map <leader>e :edit!<CR>                             " reload current file
xnoremap p pgvy
map <leader>f :Lexplore .<CR>                         " open file explorer
map <leader>F :Lexplore<CR>

"-- Macros
" repeat macro saved in 'q'
nnoremap <leader>m @q

"-- Function keys
map <F1> <ESC>
map <F2> :NERDTreeToggle<CR>
nmap <silent> <F4> ggVG           " select/highlight all
nnoremap <F9> :set spell!<CR>
nnoremap <F10> :set relativenumber!<CR>
set pastetoggle=<F12>

"-- CtrlP settings
nmap <leader>t :CtrlP<CR>
nmap <leader>T :CtrlP
nmap <leader><space> :CtrlPBuffer<CR>
let g:ctrlp_match_window_bottom = 1
let g:ctrlp_match_window_reversed = 1
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0

"-- Silver Searcher settings (ack and ctrlp)
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

"-- Command line completion
set wildmenu                 " navigate <left> & <right> through completion lists
set wildmode=full            " complete first full match, next match (default)
set wildignore+=.git         " git files
set wildignore+=*.sw?        " swap files

" tmux will send xterm-style keys when its xterm-keys option is on
if &term =~ '^screen'
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

"-- NerdCommenter settings
let NERDSpaceDelims=1

"-- Jedi settings
let g:jedi#popup_on_dot = 0
autocmd FileType python setlocal completeopt-=preview
