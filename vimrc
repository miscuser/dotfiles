" Misc vimrc

"-- Vundle
set nocompatible
filetype off

if !isdirectory(expand("~/.vim/bundle/Vundle.vim/.git"))
    !git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
endif

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"-- Plugins
Plugin 'gmarik/Vundle.vim'         " Let Vundle manage Vundle
Plugin 'Lokaltog/vim-easymotion'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-surround'
Plugin 'ervandew/supertab'
Plugin 'kien/ctrlp.vim'
Plugin 'embear/vim-foldsearch'
Plugin 'mileszs/ack.vim'
call vundle#end()                  " required
filetype plugin indent on          " required

"-- Vundle instructions
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update
" :PluginUpdate     - update plugins
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
" :h vundle         - for additional information

"-- From original template
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
map Q gq                        " don't use Ex mode, use Q for formatting
inoremap <C-U> <C-G>u<C-U>      " CTRL-G u to first break undo so you can undo CTRL-u after inserting line break
if has('mouse')                 " enable mouse
  set mouse=a
endif

"-- Custom settings
source ~/dotfiles/abbreviations.vim   " common abbreviations
set term=xterm-256color       " allow for fancy colors
set nowrap                    " wrapping off 
set textwidth=0
set hlsearch                  " highlight search
set incsearch                 " do incremental searching
set history=1000              " keep a long command history 
set undolevels=500            " allow a lot of undo activity
set ruler                     " show cursor position
set showcmd                   " display incomplete commands
set nostartofline             " do not reset cursor to start of line
set number                    " line numbers
set incsearch                 " incremental search 
set ic                        " ignore case by default in search
set scs                       " smart case search (insensitive if all lowercase; sensitive otherwise)
set clipboard=unnamed         " default to system clipboard
set nobackup                  " turn off ~ copy of each file
set nowritebackup             " don't use backup files 
set tabstop=4 shiftwidth=4 expandtab  " make tabs reasonable
set visualbell                " disable sounds
set noerrorbells              " disable beeps
set shortmess+=I              " disable welcome screen
set showmatch                 " show matching parentheses
let mapleader=","             " use comma as leader 
set cursorline                " underline current line
set spellsuggest=10
autocmd BufEnter * lcd %:p:h  " set current working directory to current buffer location
syntax on                     " syntax coloring

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
" za – toggles
" zc – closes
" zo – opens
" zR – open all
" zM – close all

"-- vim-foldsearch settings
map <silent> <leader>yo :folddoopen y
let g:foldsearch_disable_mappings=1     " disable default mappings
let g:foldsearch_highlight=1            " highlight search results

"-- Colorschemes
autocmd BufEnter *     colorscheme badwolf 
autocmd BufEnter *.txt colorscheme murphy

"-- Tabs and buffers
noremap  <leader>B :bnext<CR>
noremap  <leader>b :bprev<CR>
noremap <C-PageDown> :cnext<CR>
noremap <C-PageUp> :cprev<CR>

"-- Split screens
set splitright                             " opens new splits to the right
nnoremap <C-h> <C-w>h                      " move left between splits
nnoremap <C-j> <C-w>j                      " move down between splits
nnoremap <C-k> <C-w>k                      " move up between splits
nnoremap <C-l> <C-w>l                      " move right between splits
nnoremap <A-left> :vertical resize -5<CR>  " decrease width
nnoremap <A-right> :vertical resize +5<CR> " increase width
nnoremap <leader>w :vnew<CR><C-w>l         " create blank split

"-- Copy, highlight, and navigation
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%100v.\+/
set listchars=tab:▸\ ,eol:¬

"-- Pandoc and markdown
au BufRead,BufNewFile,BufEnter *.md,*.markdown set filetype=markdown  " set filetypes
command PDF ! pandoc -V geometry:margin=1in % -o %:r.pdf
map <silent> <leader>mp :PDF<CR>

"-- Open common files
map <silent> <leader>eb :e ~/dotfiles/bashrc<CR>              " bashrc
map <silent> <leader>ea :e ~/dotfiles/abbreviations.vim<CR>   " abbreviations
map <silent> <leader>ev :e $MYVIMRC<CR>                       " vimrc
nmap <silent> <leader>sv :so $MYVIMRC<CR>                     " source vimrc

"-- Python
command PyRun ! python %
map <silent> <leader>py :PyRun<CR>

"-- Sanity mappings
nnoremap ; :
nnoremap j gj
nnoremap k gk
inoremap jj <ESC>

"-- Misc. mappings
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>     " strip whitespace from the end of lines
nmap <leader>p :set paste!<CR>                       " toggle paste mode
nmap <silent> <leader>/ :nohlsearch<CR>              " clear highlighted search results
nmap <leader>z z=                                    " show suggested spelling
map <leader>cc :ccl<CR>                              " close the quickfix window
map <leader>co :copen<CR>                            " jump to quickfix window
map <leader>a :Ack! 

"-- Function keys
map <F1> <ESC>
map <F2> :NERDTreeToggle<CR>
map <F3> :CtrlPBuffer<CR>
nmap <silent> <F4> ggVG           " select/highlight all
nmap <silent> <F5> ggVG"+y        " copy all
nnoremap <F8> :set list!<CR>
nnoremap <F9> :set spell!<CR>
nnoremap <S-F9> ]s

"-- CtrlP settings
nmap <leader>t :CtrlP<CR>
nmap <leader>T :CtrlP 
nmap <leader>r :CtrlPBuffer<CR>
let g:ctrlp_match_window_bottom = 1
let g:ctrlp_match_window_reversed = 1
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0

"-- Silver Searcher settings (ack and ctrlp)
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif


