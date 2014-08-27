" Misc. vimrc
"
"""""""""""""""""" Vundle """""""""""""""""""""""""""""""""
" set the runtime path to include Vundle and initialize
set nocompatible                " use VIM settings instead of Vi settings
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Bundles
Plugin 'gmarik/Vundle.vim'         " Let Vundle manage Vundle
Plugin 'Lokaltog/vim-easymotion'   " EasyMotion
Plugin 'scrooloose/nerdtree'       " NerdTree
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-surround'        " Surround
call vundle#end()            " required
filetype plugin indent on    " required

" Brief help
" " :PluginList       - lists configured plugins
" " :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" " :PluginSearch foo - searches for foo; append `!` to refresh local cache
" " :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
" "
" " see :h vundle for more details or wiki for FAQ

"""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""" Everything in this section was in the template """"""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
map Q gq                        " don't use Ex mode, use Q for formatting
inoremap <C-U> <C-G>u<C-U>      " CTRL-G u to first break undo so you can undo CTRL-u after inserting line break
" Enable the mouse
if has('mouse')
  set mouse=a
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""" My custom settings """"""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nowrap               " I hate wrapping
set hlsearch             " highlight search
set incsearch		     " do incremental searching
set history=1000         " keep a long list of command lines
set undolevels=500       " allow a lot of undo activity
set ruler	    	     " show the cursor position all the time
set showcmd	    	     " display incomplete commands
set nostartofline        " do not reset cursor to start of line
set number               " turn on line numbers
set incsearch            " make search act like search in modern browsers
set ic                   " ignore case by default in search
set scs                  " smart case search (insenstive if all lowercase; sensitive otherwise) 
set clipboard=unnamed    " make the clipboard default to the system clipboard
set nobackup             " turn off the dumb ~ copy of each file
set nowritebackup        " don't use the damn backup files set noswapfile 
set tabstop=4 shiftwidth=4 expandtab  " make the tabs reasonable
set visualbell                " turn off the damn sounds
set noerrorbells              " turn off the damn beeps
set shortmess+=I              " turn off the welcome screen about Uganda
set showmatch                 " show matching parenthesis
set splitright                " puts new split windows on the right
let mapleader=","             " change the leader to comma
set formatoptions+=l          " this coupled with the next one avoid line wraps in the middle of words
set lbr                       " with line above avoids the line break problems I was seeing
set nofoldenable              " don't fold by default
colors murphy                 " set the color scheme to something I like
autocmd BufEnter * lcd %:p:h  " sets the current working directory to the current buffer location 
syntax on                     " turn on syntax coloring
au BufRead,BufNewFile *.md set filetype=markdown  " turn on highlighting for markdown files

""""""""" Make tabs easier to manage 
noremap  <C-T>      :tabnew<return>        " CTRL-T opens a new tab
noremap  <C-W>      :tabclose<return>      " CTRL-W closes a tab
noremap  <C-tab>    :tabnext<CR>           " Move between tabs with Ctrl+Tab

""""""""" Make it easy to handle split screens        
nnoremap <C-h> <C-w>h                      " move left between buffers
nnoremap <C-j> <C-w>j                      " move down between buffers
nnoremap <C-k> <C-w>k                      " move up between buffers
nnoremap <C-l> <C-w>l                      " move right between buffers
nnoremap <A-left> :vertical resize -5<cr>  " decrease the width
nnoremap <A-down> :resize -5<cr>           " decrease the height
nnoremap <A-up> :resize +5<cr>             " increase the height
nnoremap <A-right> :vertical resize +5<cr> " increase the width

""""""""" Additional custom keybindings
map <silent> <leader>ev :e $MYVIMRC<CR>    " allow for easy editing of vimrc
map <F2> :NERDTreeToggle<CR>               " map F2 to NERDTree plugin
nmap <silent> <F5> ggVG"+y                 " map F5 to copy all
nmap <silent> <F4> ggVG                    " map F4 to select/highlight all

