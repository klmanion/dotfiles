".vimrc

" Vi-compatibility {{{
"

let g:hdevtoold_stack = 1

set rtp+=/usr/local/opt/fzf

" cpoptions {{{
" options that effect the behavior of both compatibility modes
" Vim default: aAbceFs
" Vi default: (all flags)
"
" Enabling or disabling any of these options cause them to be adhered to or not
" adhered to in compatibility or non-compatibility mode
"

" When enabled, a backslash has no special meaning in mappings
" When disabled, a backslash may be used like CTRL-V
set cpo-=B

" When executing a register always add a <CR> to the last line
" Disabled this allows editing of the last line before execution
set cpo+=e

" When enabled, goto line 1 when using :edit without argument
set cpo-=g

" When enabled, interrupting the reading of a file will leave it modified
set cpo-=i

" Do not allow for the autocompletion of incomplete key mappings
" Allows one to cancel any command they have not finished typing
" Enable this for vi key mapping autocompletion
" Also see cpo-k
set cpo-=K

" Enabled, backslash in a regex's [] range is taken literally,
" only `\]', `\^', `\-', and `\\' are special
" cpo-l

" Excluded, `%' matching will take backslashes into account
set cpo-=M

" Excluded, uses a better algorithm for Lisp indentation
set cpo-=p

" Included, rubed-out character remain visible on the screen and are
" overwritten by newly typed text
" cpo-v

" Dont overwrite a readonly file
set cpo+=WZ

" <Esc> on the command-line executes the command-line
set cpo-=x

" Excluded, parenthesis inside quotations are treated specially
set cpo-=%

" Included, disables recognition of special key codes in <> form
set cpo-='<'

" }}}

set nocompatible
" }}}

" Color {{{
"

" set notermguicolors
let &t_Co=256
colorscheme default
" even though I use a dark terminal I prefer the colors used for light
" backgtrounds
set background=light
" }}}

" Misc settings {{{
"
set hidden

set wildmenu

set showcmd

set nohlsearch

set ignorecase
set smartcase

set backspace=indent,eol,start

set nostartofline
" }}}

" Folding rules {{{
"
set foldenable
if &foldenable
	set foldmethod=marker
	set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
	set foldlevelstart=1
	
	" add a fold collumn
	set foldcolumn=3
endif
" }}}

" Status line {{{
"
set noruler
set laststatus=2
set statusline=%<%f\ %m
set statusline+=%= " left-right divider
set statusline+=%y\ %l:%c%V\ --\ %p%%
" }}}

" Syntax {{{
"
filetype on
filetype indent plugin on

syntax on

set number

set ts=8
set sw=8
set noexpandtab
set tw=79

set cindent
let c_syntax_for_h = 1

imap <C-l> λ

set lispwords+=define/contract,λ

" Filetype autocommands {{{
if has('autocmd')
	augroup Racket " {{{
		autocmd!
		au BufReadPost *.rkt,*.rktl set syntax=racket filetype=racket
		au FileType racket set nocindent
		au FileType racket set autoindent
		au FileType racket set lisp
		au FileType racket set ts=2
		au FileType racket set sw=2
		au FileType racket set expandtab
	augroup END " }}}
	augroup c " {{{
		autocmd!
		au FileType c set ts=8
		au FileType c set sw=8
		au FileType c set noexpandtab
		au FileType c set cinoptions=
		au FileType c set cino+=>s,e0,n-.5s,f0,{.5s,}0,^0
		au FileType c set cino+=Ls,:0,=s,l1,b0
		au FileType c set cino+=g0,hs,N-s,E-s,i0
		au FileType c set cino+=p.5s,+s,t0
		au FileType c set cino+=c3,c1,/0
		au FileType c set cino+=(0,us,U1,w0,W.5s,ks,m0,M0
		au FileType c set cino+=j1,J1 " these are java settings
		au FileType c set cino+=)80,*200,#0
	augroup END " }}}
	augroup cpp " {{{
		autocmd!
		au FileType cpp set ts=8
		au FileType cpp set sw=8
		au FileType cpp set noexpandtab
		au FileType cpp set cinoptions=
		au FileType cpp set cino+=>s,e0,n-.5s,f0,{.5s,}0,^0
		au FileType cpp set cino+=Ls,:0,=s,l1,b0
		au FileType cpp set cino+=g0,hs,N-s,E-s,i0
		au FileType cpp set cino+=p.5s,+s,t0
		au FileType cpp set cino+=c3,C1,/0
		au FileType cpp set cino+=(0,us,U1,w0,W.5s,ks,m0,M0
		au FileType cpp set cino+=j1,J1 " these are java settings
		au FileType cpp set cino+=)80,*200,#0
	augroup END " }}}
endif
" }}}

set modeline
set modelines=5

" TODO: make this dynamic by filetype
nmap m o/* vi: set ts=8 sw=8 noexpandtab tw=79: */<ESC>

" }}}

" Plugins {{{1
"
" Vim-Airline {{{2
let g:airline_powerline_fonts = 1
let g:airline_theme = 'base16'

set laststatus=2
set noshowmode

" VimTeX {{{2
"let g:vimtex_view_general_viewer='/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_viewer='/usr/local/bin/okular'
let g:vimtex_view_general_options='-r @line @pdf @tex'
let g:vimtex_fold_enabled=0

" GTags {{{2
"let Gtags_VerticalWindow = 0
"let Gtags_Auto_Map = 1
"let Gtags_Auto_Update = 1
"let Gtags_No_Auto_Jump = 0
"let Gtags_Close_When_Single = 1
"
"let GtagsCscope_Auto_Map = 1
"let GtagsCscope_Auto_Load = 1

" cscope {{{1
if has("cscope")
	set csprg=/usr/local/bin/cscope
	set csto=0
	set cscopetag
	set nocsverb
	if filereadable("cscope.out")
		cs add cscope.out
	elseif $CSCOPE_DB != ""
		cs add $CSCOPE_DB
	endif
	set csverb
endif
" }}}1

""" ORG
"" workflow

""" vim-plug {{{1
""

"" bootstrap {{{2
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif " }}}2

call plug#begin()

"Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'lervag/vimtex'

call plug#end()

" vi: set ts=8 sw=8 noexpandtab tw=79:
