" Misc vimrc

""""""""" Vundle 
set nocompatible 
filetype off

# Autoload Vundle if it not installed
if !isdirectory(expand("~/.vim/bundle/Vundle.vim/.git"))
    !git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
endif

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugins 
Plugin 'gmarik/Vundle.vim'         " Let Vundle manage Vundle
Plugin 'Lokaltog/vim-easymotion'
Plugin 'scrooloose/nerdtree'   
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-surround' 
call vundle#end()                  " required

filetype plugin indent on          " required

" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update
" :PluginUpdate     - update plugins
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
" :h vundle         - for additional information

""""""""" From original template
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
map Q gq                        " don't use Ex mode, use Q for formatting
inoremap <C-U> <C-G>u<C-U>      " CTRL-G u to first break undo so you can undo CTRL-u after inserting line break
if has('mouse')                 " enable mouse
  set mouse=a
endif

""""""""" My custom settings """"""""""""""""""""""""""""
set nowrap               " I hate wrapping
set textwidth=0
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
set nowritebackup        " don't use the backup files set noswapfile 
set tabstop=4 shiftwidth=4 expandtab  " make the tabs reasonable
set visualbell                " turn off the sounds
set noerrorbells              " turn off the beeps
set shortmess+=I              " turn off the welcome screen about Uganda
set showmatch                 " show matching parenthesis
set splitright                " puts new split windows on the right
let mapleader=","             " change the leader to comma
set nofoldenable              " don't fold by default
set cursorline                " underline the current line
autocmd BufEnter * lcd %:p:h  " sets the current working directory to the current buffer location 
syntax on                     " turn on syntax coloring
au BufRead,BufNewFile *.md set filetype=markdown  " turn on highlighting for markdown files

""""""""" Colors
"colors murphy             
"colors twilight 
"colors evening 
"colors koehler 
colors ron 
"colors slate 
"colors default 
autocmd BufEnter *.txt colorscheme Murphy " always use Murphy for text files 

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
map <silent> <leader>t :e /cygdrive/c/home/notes/notes.md<CR> " open todo file
map <silent> <leader>mp :! /cygdrive/c/bin/scripts/markdown_to_pdf.py %<CR> " markdown to PDF
map <silent> <leader>ev :e $MYVIMRC<CR>    " allow for easy editing of vimrc
map <F2> :NERDTreeToggle<CR>               " map F2 to NERDTree plugin
nmap <silent> <F5> ggVG"+y                 " map F5 to copy all
nmap <silent> <F4> ggVG                    " map F4 to select/highlight all

"""""""" Testing
map ,hi :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>


