let using_neovim = has('nvim')
let using_vim = !using_neovim

set nocompatible

let $VIMHOME=expand('<sfile>:p:h')

let s:mswin = has('win32') || has('win64')

if s:mswin
  set rtp=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

" Source a local configuration file if available.
if using_neovim
    let pre_vim_path = "~/.config/nvim/pre.vim"
else
    let pre_vim_path = "~/.vim/pre.vim"
endif
if filereadable(expand(pre_vim_path))
  execute "source " . pre_vim_path
endif

set t_Co=256

set langmenu=en

"filetype off

function! EnsureTmpDir(dirlst)
  let l:d = split(a:dirlst, ",")[0]
  while l:d[-1:] == '/'
    let l:d = l:d[:-2]
  endwhile
  if !isdirectory(expand(l:d))
    call mkdir(expand(l:d), "p")
  endif
endfunction

if using_neovim
    call plug#begin("~/.local/share/vim-plug/nvim")
else
    call plug#begin("~/.local/share/vim-plug/vim")
endif

" Plugins from their authors' repos:
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'mileszs/ack.vim'
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

Plug 'kien/ctrlp.vim'
let g:ctrlp_working_path_mode = 2
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = '~/.vimtmp/ctrlp'
call EnsureTmpDir(g:ctrlp_cache_dir)
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$',
  \ 'file': '\.exe$\|\.so$\|\.dll$',
  \ }

Plug 'kien/rainbow_parentheses.vim'
autocmd VimEnter * RainbowParenthesesToggle
autocmd Syntax * RainbowParenthesesLoadRound
autocmd Syntax * RainbowParenthesesLoadSquare
autocmd Syntax * RainbowParenthesesLoadBraces

Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'

Plug 'tpope/vim-surround'
set encoding=utf-8
Plug 'bling/vim-airline'
"if !exists('g:airline_symbols')
"  let g:airline_symbols = {}
"endif
"" unicode symbols
""let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"
""let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'

""let g:airline_symbols.linenr = '␊'
""let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'

""let g:airline_symbols.branch = '⎇'

""let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
""let g:airline_symbols.paste = '∥'

"let g:airline_symbols.whitespace = 'Ξ'

let g:airline_powerline_fonts = 1

set noshowmode
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#buffer_idx_mode = 1

Plug 'Lokaltog/vim-easymotion'

Plug 'majutsushi/tagbar'
if s:mswin
  let g:tagbar_ctags_bin = '~/bin/ctags.exe'
endif
nmap <F8> :TagbarToggle<CR>

if s:mswin
  Plug 'rstacruz/sparkup', {'rtp': 'vim'}
else
  Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
endif
Plug 'AndrewRadev/linediff.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'Townk/vim-autoclose'
Plug 'bogado/file-line'
Plug 'pangloss/vim-javascript'
Plug 'davidhalter/jedi-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'mitsuhiko/vim-jinja'
Plug 'terryma/vim-multiple-cursors'
Plug 'Yggdroot/indentLine'
Plug 'mbbill/undotree'
Plug 'tpope/vim-fugitive'
"Plug 'bronson/vim-trailing-whitespace'
Plug 'ntpeters/vim-better-whitespace'
"Plug 'ciaranm/detectindent'
"Plug 'vim-pandoc/vim-pandoc'
"Plug 'Rykka/riv.vim'
"Plug 'nathanaelkane/vim-indent-guides'
Plug 'mtth/scratch.vim'
"Plug 'wincent/ferret.vim'
"
" https://github.com/hynek/vim-python-pep8-indent
Plug 'hynek/vim-python-pep8-indent'

"if using_neovim
"  Plug 'floobits/floobits-neovim'
"endif

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
Plug 'lotabout/skim.vim'

if using_neovim && vim_plug_just_installed
    Plug 'Shougo/deoplete.nvim', {'do': ':autocmd VimEnter * UpdateRemotePlugins'}
else
    Plug 'Shougo/deoplete.nvim'
endif

if using_vim
    " Consoles as buffers (neovim has its own consoles as buffers)
    Plug 'rosenfeld/conque-term'
    " XML/HTML tags navigation (neovim has its own)
    Plug 'vim-scripts/matchit.zip'
endif

if has('python')
  Plug 'ramiro/sort-python-imports'
endif

" vim-scripts repos
Plug 'vim-scripts/VOoM'
Plug 'vim-scripts/TaskList.vim'
Plug 'vim-scripts/matchit.zip'
"Plug 'vim-scripts/spacehi.vim'
Plug 'vim-scripts/Align'
Plug 'vim-scripts/loremipsum'
Plug 'vim-scripts/bufexplorer.zip'
"Plug 'vim-scripts/AutoComplPop'
Plug 'vim-scripts/snippetsEmu'
Plug 'vim-scripts/vcscommand.vim'
"Plug 'vim-scripts/SearchComplete'
Plug 'vim-scripts/indenthtml.vim'

" Python indentation
" http://www.vim.org/scripts/script.php?script_id=3003
"Plug 'vim-scripts/indentpython.vim'
" http://www.vim.org/scripts/script.php?script_id=3461
"Plug 'vim-scripts/indentpython.vim--nianyang'

" colorschemes
Plug 'altercation/vim-colors-solarized'
Plug 'vim-scripts/desert256.vim'
Plug 'sjl/badwolf'
Plug 'NLKNguyen/papercolor-theme'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'rakr/vim-one'
Plug 'mhartington/oceanic-next'
Plug 'romainl/flattened'
call plug#end()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50 " keep 50 lines of command line history
set ruler      " show the cursor position all the time
set showcmd    " display incomplete commands

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
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
autocmd!

" For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   execute "normal! g`\"" |
  \ endif

augroup END

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
endif

if s:mswin
  behave mswin

  set diffexpr=

  " For Windows GUI: remove 't' flag from 'guioptions': no tearoff menu entries
  let &guioptions = substitute(&guioptions, "t", "", "g")
  set guifont=DejaVu_Sans_Mono:h9:cANSI
  " Better gvim font rendering on Windows since 7.4.393
  set renderoptions=type:directx,gamma:1.0,contrast:0.2,level:1.0,geom:1,renmode:5,taamode:1
else
  language en_US.UTF-8
endif

" let $LANG='en'
" set helplang=en

" No toolbar
set guioptions-=T

"colorscheme desert256

set virtualedit=all

set incsearch " do incremental searching
" switch on highlighting the last used search pattern when the terminal has
" colors
if &t_Co > 2 || has("gui_running")
  set hlsearch
endif

set cursorline
"set cursorcolumn

" set visualbell
"set errorbells
" don't bell or blink
set noerrorbells
set visualbell t_vb=
set nowrap
set scrolloff=3
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

"autocmd BufWritePre * call RemoveTrailingWhitespace()

" Maximize window size for gvim
function! ToggleFullScreen()
  call system("wmctrl -i -r ".v:windowid." -b toggle,maximized_vert,maximized_horz")
  redraw
endfunction
if has("gui_running")
  if s:mswin
    autocmd GUIEnter * simalt ~x
  else
    autocmd GUIEnter * call ToggleFullScreen()
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
set hidden
" clear the search buffer with <Leader>/
nmap <silent> <Leader>/ :nohlsearch<CR>
"nmap <silent> <Leader><space> :nohlsearch<CR>
"
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
"set ignorecase
" ignore case if search pattern is all lowercase, case-sensitive otherwise
"set smartcase
" insert tabs on the start of a line according to shiftwidth, not tabstop
set smarttab
" set noerrorbells
set wildignore=*.swp,*.bak,*.pyc,*.class
" backup related settings
set backup
set backupdir=~/.vimtmp/backup//,.
call EnsureTmpDir(&backupdir)
set directory=~/.vimtmp/swap//,.
call EnsureTmpDir(&directory)

" forgot sudo?, use :w!!
"cmap w!! w !sudo tee % >/dev/null
" show status when there is no buffer
set laststatus=2

set number
if v:version >= 703
  " undo related settings
  set undofile
  set undodir=~/.vimtmp/undo,.
  call EnsureTmpDir(&undodir)

  "set colorcolumn=80
  "autocmd filetype mail set colorcolumn=72
  set colorcolumn=+1
  " fancy line numbers
  " set relativenumber
"else
"  set number
  " Colums markers when writing Git/Hg commit messages
  autocmd BufRead hg-editor*,COMMIT_EDITMSG set tw=72 colorcolumn=51,+1
  " To get syntax coloring when composing email on GMail with Vim via the
  " 'It's all text' Firefox extension
  autocmd BufRead mail.google.com.*.txt set ft=mail
endif
" faster operations
set ttyfast
" no vim regexps, use perl ones
nnoremap / /\v
vnoremap / /\v

set splitbelow splitright

augroup filetypedetect
" TaskJuggler files
autocmd! BufRead,BufNewFile *.tjp,*.tji    setfiletype tjp
" .ini files
autocmd! BufRead,BufNewFile *.ini,*/.hgrc,*/hgrc set filetype=dosini
" Jinja files
autocmd BufRead,BufNewFile *.jinja,*/.jinja2 set filetype=jinja
" editmoin files
autocmd! BufRead,BufNewFile *.moin set filetype=moin1_5
augroup END

autocmd! Syntax tjp    source ~/.vim/syntax/tjp.vim

" Don't warn on missing docstrings
let g:syntastic_python_pylint_args='-d C0111'

" 256 colors on macos + iterm
" see https://jdhao.github.io/2018/10/19/tmux_nvim_true_color/
set termguicolors

" Trying some mapping for fzf. See https://medium.com/@jesseleite/its-dangerous-to-vim-alone-take-fzf-283bcff74d21
nmap <Leader>F :Files<CR>
nmap <Leader>/ :Rg<Space>
nnoremap <silent> <Leader>rg :Rg <C-R><C-W><CR>

" skim
"command! -bang -nargs=* Rg call fzf#vim#rg_interactive(<q-args>, fzf#vim#with_preview('right:50%:hidden', 'alt-h'))

au FileType python map <silent> <leader>b Oimport ipdb; ipdb.set_trace()<esc>

" Source a local configuration file if available.
if using_neovim
    let post_vim_path = "~/.config/nvim/post.vim"
else
    let post_vim_path = "~/.vim/post.vim"
endif
if filereadable(expand(post_vim_path))
  execute "source " . post_vim_path
endif

if s:mswin
  set rtp^=$HOME/.vim/
endif
