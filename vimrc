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
set nobackup             " turn off the ~ copy of each file
set nowritebackup        " don't use the backup files set noswapfile 
set tabstop=4 shiftwidth=4 expandtab  " make tabs reasonable
set visualbell                " turn off the sounds
set noerrorbells              " turn off the beeps
set shortmess+=I              " turn off the welcome screen about Uganda
set showmatch                 " show matching parenthesis
let mapleader=","             " change the leader to comma
set cursorline                " underline the current line
autocmd BufEnter * lcd %:p:h  " sets the current working directory to the current buffer location 
syntax on                     " turn on syntax coloring

"-- Status line
set laststatus=2
set statusline=
set statusline+=%7*\[%n]                                  " buffer
set statusline+=%1*\ %<%F\                                " file+path
set statusline+=%2*\ %y\                                  " file type
set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      " encoding
set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            " encoding2
set statusline+=%4*\ %{&ff}\                              " file format (dos/unix) 
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

"-- Customizations for vim-foldsearch
map <silent> <leader>yo :folddoopen y 
let g:foldsearch_disable_mappings=1     " disable default mappings
let g:foldsearch_highlight=1        " highlight search results

"-- Colorschemes
autocmd BufEnter *     colorscheme ron 
autocmd BufEnter *.txt colorscheme murphy 
"autocmd BufEnter *.markdown colorscheme default 

"-- Tabs and buffers 
noremap  <C-T> :tabnew<CR>
noremap  <C-W> :tabclose<CR>
noremap  <leader>B :bnext<CR>
noremap  <leader>b :bprev<CR>
noremap <C-PageDown> :cnext<CR>
noremap <C-PageUp> :cprev<CR>
map <F3> :buffers<CR>

"-- Split screens 
set splitright                             " puts new split windows on the right
nnoremap <C-h> <C-w>h                      " move left between splits 
nnoremap <C-j> <C-w>j                      " move down between splits
nnoremap <C-k> <C-w>k                      " move up between splits
nnoremap <C-l> <C-w>l                      " move right between splits
nnoremap <A-left> :vertical resize -5<cr>  " decrease the width
nnoremap <A-down> :resize -5<cr>           " decrease the height
nnoremap <A-up> :resize +5<cr>             " increase the height
nnoremap <A-right> :vertical resize +5<cr> " increase the width

"-- Copy, highlight, navigation 
map <F2> :NERDTreeToggle<CR>               " map F2 to NERDTree plugin
nmap <silent> <F5> ggVG"+y                 " map F5 to copy all
nmap <silent> <F4> ggVG                    " map F4 to select/highlight all
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%100v.\+/

"-- Pandoc and markdown 
au BufRead,BufNewFile,BufEnter *.md,*.markdown set filetype=markdown  " set filetypes 
command PDF ! pandoc -V geometry:margin=1in % -o %:r.pdf
command HTML ! pandoc -V geometry:margin=1in % -o %:r.html
map <silent> <leader>mp :PDF<CR>
map <silent> <leader>mh :HTML<CR>

"-- Open common files
map <silent> <leader>ev :e $MYVIMRC<CR> 

"-- Compiling
command PyRun ! python %
map <silent> <leader>py :PyRun<CR>

