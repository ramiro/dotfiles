" Ramiro's .vimrc for Vim 7
set langmenu=en
" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible " Also needed by Vundle
filetype off " needed by Vundle

" Setting up Vundle - the vim plugin bundler
let iCanHazVundle=1
if has('win32') || has('win64')
  let vundle_readme=expand('~/vimfiles/bundle/vundle/README.md')
else
  let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
endif
if !filereadable(vundle_readme)
  echo "Installing Vundle..."
  echo ""
  if has('win32') || has('win64')
    silent !mkdir -p ~/.vimfiles/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vimfiles/bundle/vundle
  else
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
  endif
  let iCanHazVundle=0
endif

" Vundle
if has('win32') || has('win64')
  set rtp+=~/vimfiles/bundle/vundle/
else
  set rtp+=~/.vim/bundle/vundle/
endif
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'ramiro/vundle'

" Bundles from their authors' repos:
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'mileszs/ack.vim'
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

Bundle 'kien/ctrlp.vim'
let g:ctrlp_working_path_mode = 2
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = '~/.vimtmp/ctrlp'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$',
  \ 'file': '\.exe$\|\.so$\|\.dll$',
  \ }

Bundle 'kien/rainbow_parentheses.vim'
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

Bundle 'xolox/vim-session'
Bundle 'tpope/vim-surround'
Bundle 'vim-pandoc/vim-pandoc'
Bundle 'Lokaltog/vim-powerline'
set encoding=utf-8
let g:Powerline_symbols = 'unicode'

Bundle 'Lokaltog/vim-easymotion'

Bundle 'majutsushi/tagbar'
if has('win32') || has('win64')
  let g:tagbar_ctags_bin = '~/bin/ctags.exe'
endif
nmap <F8> :TagbarToggle<CR>

Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'altercation/vim-colors-solarized'
Bundle 'AndrewRadev/linediff.vim'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'Townk/vim-autoclose'
Bundle 'bogado/file-line'

" vim-scripts repos
Bundle 'VOoM'
Bundle 'indentpython.vim'
Bundle 'TaskList.vim'
Bundle 'matchit.zip'
Bundle 'spacehi.vim'
if has('python')
  Bundle 'ramiro/sort-python-imports'
endif
Bundle 'Align'
Bundle 'loremipsum'
Bundle 'bufexplorer.zip'
Bundle 'ini-syntax-definition'
"Bundle 'AutoComplPop'
Bundle 'snippetsEmu'
Bundle 'vcscommand.vim'
"Bundle 'SearchComplete'

" colorschemes
Bundle 'desert256.vim'
Bundle 'sjl/badwolf'

" Installing plugins the first time
if iCanHazVundle == 0
  echo "Installing Bundles, please ignore key map error messages"
  echo ""
  :BundleInstall
endif

" source $VIMRUNTIME/vimrc_example.vim
" Last change:	2011 Apr 15 (vim 7.3.470)
"=============================================================================
" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  "set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
"=============================================================================

if has('win32') || has('win64')
  " source $VIMRUNTIME/mswin.vim
  behave mswin

  set diffexpr=

  " For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
  let &guioptions = substitute(&guioptions, "t", "", "g")
  set guifont=DejaVu_Sans_Mono:h9:cANSI
else
  lang en_US.UTF-8
endif

" let $LANG='en'
" set helplang=en

" No toolbar
set guioptions-=T

"if has("gui_running")
"  set t_Co=256
"  colorscheme desert256
"else
"  colorscheme inkpot
"endif
set t_Co=256
"au VimEnter * colorscheme desert256
colorscheme desert256

set virtualedit=all

set incsearch		" do incremental searching
set hlsearch

set cursorline
"set cursorcolumn

" set visualbell
set errorbells
set nowrap
set scrolloff=2
set wildmode=longest,list,full
set wildmenu

" Remove all trailing whitespace in a file and return the cursor to its
" original position
function! RemoveTrailingWhitespace()
  if &ft =~? 'diff\|mail\|make'
    return
  endif
  let l:searchreg = getreg('/')
  let l:searchregtype = getregtype('/')
  let l:curcol = col(".")
  let l:curline = line(".")
  " use silent! so we suppress the 'pattern not found' message
  silent! %s/\s\+$//
  call cursor(l:curline, l:curcol)
  call setreg('/', l:searchreg, l:searchregtype)
endfunction

autocmd BufWritePre * call RemoveTrailingWhitespace()

" for editmoin:
au! BufRead,BufNewFile *.moin set filetype=moin1_5

" Maximize window size for gvim
if has("gui_running")
  if has('win32')
    au GUIEnter * simalt ~x
  "else
  "  set lines=99999 columns=99999
  endif
endif

" for the python autocomplete plugin
autocmd FileType python set omnifunc=pythoncomplete#Complete

" Nice formatting of numbered lists
set formatoptions+=n

" Nice tips from http://nvie.com/posts/how-i-boosted-my-vim/
" and http://stevelosh.com/blog/2010/09/coming-home-to-vim/

" change the mapleader from \ to ,
let mapleader=","
" don't unload buffers when abandoning them, can be unsaved
"set hidden
" clear the search buffer with <leader>/
nmap <silent> <leader>/ :nohlsearch<CR>
"nmap <silent> <leader><space> :nohlsearch<CR>
" no arrow keys, hjkl FTW
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
" even further, not even in interactive mode
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
" shorter to type prefix for every vim command (; v. Shift+; (:))
"nnoremap ; :
" paste preformatted/preindented code w/o vim indenting it again
set pastetoggle=<F2>
" visible space when list is on
"set listchars=tab:>.,trail:.,extends:#,nbsp:.
" I use spacehi for traling spaces
set listchars=tab:>.,extends:#,nbsp:.
autocmd filetype html,xml set listchars-=tab:>.
" use multiple of shiftwidth when indenting with '<' and '>'
set shiftround
" ignore case if search pattern is all lowercase, case-sensitive otherwise
set smartcase
" insert tabs on the start of a line according to shiftwidth, not tabstop
set smarttab
" set noerrorbells
set wildignore=*.swp,*.bak,*.pyc,*.class
" backup related settings
set backup
set backupdir=~/.vimtmp/backup//,.
"if !isdirectory(expand(&backupdir)) call mkdir(expand(&backupdir), "p") endif
set directory=~/.vimtmp/swap//,.
"if !isdirectory(expand(&directory)) call mkdir(expand(&directory), "p") endif
"
" forgot sudo?, use :w!!
cmap w!! w !sudo tee % >/dev/null
" show status when there is no buffer
set laststatus=2

set number
if v:version >= 703
  " undo related settings
  set undofile
  set undodir=~/.vimtmp/undo,.
  "if !isdirectory(expand(&undodir)) call mkdir(expand(&undodir), "p") endif
  "
  "set colorcolumn=80
  "autocmd filetype mail set colorcolumn=72
  set colorcolumn=+1
  " fancy line numbers
  " set relativenumber
"else
"  set number

  au BufRead hg-editor*,COMMIT_EDITMSG set tw=72 colorcolumn=51,+1
  au BufRead mail.google.com.*.txt set ft=mail
endif
" faster operations
set ttyfast
" no vim regexps, use perl ones
nnoremap / /\v
vnoremap / /\v

set splitbelow splitright

" for TaskJuggler
augroup filetypedetect
au BufNewFile,BufRead *.tjp,*.tji    setf tjp
augroup END

au! Syntax tjp    so ~/vimfiles/syntax/tjp.vim

" Source a local configuration file if available.
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
