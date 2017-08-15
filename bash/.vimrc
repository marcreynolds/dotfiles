set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" https://github.com/tpope/vim-fugitive
Plugin 'tpope/vim-fugitive'

" https://github.com/tpope/vim-rails
Plugin 'tpope/vim-rails'

" https://github.com/tpope/vim-endwise
Plugin 'tpope/vim-endwise'

" https://github.com/christoomey/vim-tmux-navigator
Plugin 'christoomey/vim-tmux-navigator'

" https://github.com/scrooloose/nerdtree
Plugin 'scrooloose/nerdtree'

" https://github.com/Xuyuanp/nerdtree-git-plugin
Plugin 'Xuyuanp/nerdtree-git-plugin'

" http://www.vim.org/scripts/script.php?script_id=508
" Press <c-w>o : the current window zooms into a full screen
" Press <c-w>o again: the previous set of windows is restored
Plugin 'ZoomWin'

" https://github.com/flazz/vim-colorschemes/tree/master/colors
Plugin 'flazz/vim-colorschemes'

Plugin 'terryma/vim-multiple-cursors'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'airblade/vim-gitgutter'

Plugin 'mileszs/ack.vim'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install -all' }
Plugin 'scrooloose/nerdcommenter'

Plugin 'kchmck/vim-coffee-script'

set runtimepath^=~/.vim/bundle/auto_autoread/plugin/auto_autoread.vim

"Plugin 'marcreynolds/auto_autoread'
" https://github.com/jeetsukumaran/vim-buffergator

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

colorscheme onedark

set number            " Show line numbers
set ruler             " Show line and column number
syntax enable         " Turn on syntax highlighting allowing local overrides

""
"" Whitespace
""

set nowrap                        " don't wrap lines
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs
set list                          " Show invisible characters
set backspace=indent,eol,start    " backspace through everything in insert mode

" List chars
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is

""
"" Searching
""

set hlsearch    " highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter

" NERDTree Open Binding
nnoremap <Leader>n :NERDTreeToggle<Enter>
nmap ,n :NERDTreeFind<Enter>

" reload vim settings
nnoremap <Leader>r :source ~/.vimrc<Enter>

" tmux nav settings
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
" nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

" Write all buffers before navigating from Vim to tmux pane
let g:tmux_navigator_save_on_switch = 2

" Disable temp and backup files
set wildignore+=*.swp,*~,._*

""
"" Backup and swap files
""

set backupdir^=~/.vim/_backup//    " where to put backup files.
set directory^=~/.vim/_temp//      " where to put swap files.

if executable('ag')
  let g:ackprg="ag --nocolor --nogroup --column"
endif

nnoremap <c-t> :FZF<cr>
nnoremap <c-p> :FZF<cr>

" column highlighting
set cursorcolumn
set cursorline
set colorcolumn=80
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" change up the cursors
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
"let g:togglecursor_default = 'underline'
"let g:togglecursor_leave = 'block'
"let g:togglecursor_insert = 'blinking_line'

" always show the status line
set laststatus=2

" set up the clipboard
set clipboard=unnamed
noremap <Leader>y "*y
noremap <Leader>Y "*Y
noremap <Leader>p "*p

" auto-reload modified changes
:au FocusGained,BufEnter * :silent! !

" auto-save changes
:au FocusLost,WinLeave,CompleteDone * :silent! w

" don't make a backup when overwriting files
set nobackup
set nowritebackup
set nornu
function! NumberToggle()
  if(&rnu == 1)
    set nornu
  else
    set rnu
  endif
endfunc

noremap <Leader>l :call NumberToggle()<cr>

" FZF lovin'
let g:fzf_files_options =
  \ '--reverse ' .
  \ '--preview "(coderay {} || cat {}) 2> /dev/null | head -'.&lines.'"'
"nnoremap <leader>f :Files<cr>
"nnoremap <leader>dc :Files app/controllers<cr>
"nnoremap <leader>dm :Files app/models<cr>
"nnoremap <leader>dv :Files app/views<cr>
"nnoremap <leader>ds :Files spec/<cr>
