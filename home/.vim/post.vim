:let g:session_autoload = 'no'
:let g:session_autosave = 'no'

"set regexpengine=1

colorscheme desert256
"colorscheme molokai
"colorscheme badwolf

"If you are going to use Solarized in Terminal mode (i.e. not in a GUI
"version like gvim or macvim), please please please consider setting your
"terminal emulator's colorscheme to use the Solarized palette. I've
"included palettes for some popular terminal emulator as well as Xdefaults
"in the official Solarized download available from Solarized homepage. If
"you use Solarized without these colors, Solarized will need to be told to
"degrade its colorscheme to a set compatible with the limited 256 terminal
"palette (whereas by using the terminal's 16 ansi color values, you can set
"the correct, specific values for the Solarized palette).

"If you do use the custom terminal colors, solarized.vim should work out of
"the box for you. If you are using a terminal emulator that supports 256
"colors and don't want to use the custom Solarized terminal colors, you will
"need to use the degraded 256 colorscheme. To do so, simply add the
"following line before the colorschem solarized line:

set background=dark
"if !s:mswin && !has("gui_running")
if has("unix") && !has("gui_running")
  let g:solarized_termcolors=256
endif
"colorscheme solarized

"colorscheme PaperColor

if has("unix") && has("gui_running")
  set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 12
endif

" So cursor ends at the right place after a yank with y. See
" http://ddrscott.github.io/blog/2016/yank-without-jank/
vnoremap <expr>y "my\"" . v:register . "y`y"
