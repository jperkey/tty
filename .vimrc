" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2000 Mar 29
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.

map               <F1> :set number! number?<CR>
map               <F2> :set paste! paste?<CR>
set                     pastetoggle=<F2>
map               <F3> :set list! nolist?<CR>
map               <F4> :Align != >= <= =\+ , # \/\/ \/\* \*\/ <CR>
"map              <F5> /SIMERROR\\|^FATAL\\|^ERROR\\|Error:\\|^WARN\\|Warning-\\|started at .* failed at <CR>
map               <F5> /\<error:\\|--- Stack trace follows:\\|Error-\\|vcs_sim_exe:.*Assertion.*failed<CR>
map               <F6> /^\w\+:$\|Retired<CR>
nnoremap <silent> <F7> :Tlist<CR>
nnoremap <silent> <F8> :CVSGotoOriginal<CR>
map               <F9> :AlignCtrl IlCP0p0<CR>
map               <F10> :!dssc co -get %<CR>
map               <F11> :!perl -c % \|& tee ~/.vim/perlout<CR>:bel split ~/.vim/perlout<CR>:1<CR>^W p<CR>
map               s    ^W+
map               S    ^W-
map               f    ^W^W

map gD :!firefox "http://www.m-w.com/cgi-bin/dictionary?book=Dictionary&va=<cword>" >& /dev/null &<CR><CR>
map gG :!firefox "http://www.google.com/search?q=<cword>"                           >& /dev/null &<CR><CR>
map gS :!firefox "http://siyobik.info.gf/main/reference/instruction/<cword>"        >& /dev/null &<CR><CR>

runtime! autoload/pathogen.vim
if exists('g:loaded_pathogen')
	call pathogen#runtime_prepend_subdirectories(expand('~/.vim/bundles'))
end

set path+=simenv/../ucode

set vb t_vb=    "Turn off the SYSTEM BEEP AND VISUAL BEEP

set nocompatible


set nowrap         " Don't wrap long lines
" set lines=25       " Initial size for gvim
" set columns=120    "  ^^^
" set lines=25       " Initial size for gvim
set cindent        " But don't do wacky C style indenting
set bs=2		       " allow backspacing over everything in insert mode
set showmatch      " always set showmatch on
set expandtab      " Use spaces instead of tabs
set softtabstop=2  " Use spaces instead of tabs
set tabstop=2      " If you insist on using tabs, use the same tabstop
" Show tab characters, show trailing spaces instead of ^I for tab and $ for eol
set listchars=tab:+-,trail:_
" set backup		     " keep a backup file (defaults to .filename~)
set viminfo='20,\"50  " read/write a .viminfo file, don't store more than 50 lines of registers
set history=50     " keep 50 lines of command line history
set ruler          " show the cursor position all the time
set showcmd
" set foldmethod=syntax
set notimeout      " no command timeout
" set smartindent    
set hidden
set timeoutlen=1000
set matchtime=10
set shiftwidth=4
set ve=block
"set laststatus=2
set scrolloff=1
set magic
set tabpagemax=32

" searching
set autoindent
set incsearch
set ignorecase
set smartcase


" colors torte
" set guifont=monotype-andale 
set mouse=a
set wildmenu

set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.toc

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

autocmd BufNewFile,BufRead Makefile set noexpandtab " Makefiles ensure that we don't expand tabs since tabs are special

autocmd FileType c,cpp nmap <tab> =0<CR>
function! InsertTabWrapper(direction)
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<TAB>"
    elseif a:direction == "backward"
        return "\<c-n>"
    else
        return "\<c-p>"
    endif
endfunction

if &term == "xterm" || &term == "vt220"
  set t_ti="^[7^[[?47h"
  set t_te="^[[2J^[[?47l^[8"
endif

inoremap <TAB> <c-r>=InsertTabWrapper("forward")<cr>
inoremap <S-TAB> <c-r>=InsertTabWrapper("backward")<cr>

" lhs comments -- select a range then hit ,# to insert hash comments
" or ,/ for // comments, or ,c to clear comments.
" map ,# :s/^/#/<CR> <Esc>:nohlsearch <CR>
" map ,/ :s/^/\/\//<CR> <Esc>:nohlsearch <CR>
" map ,c :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR> <Esc>:nohlsearch<CR>

" wrapping comments -- select a range then hit ,* to put  /* */ around
" selection, or ,d to clear them
map ,* :s/^\(.*\)$/\/\* \1 \*\//<CR> <Esc>:nohlsearch<CR>
map ,d :s/^\([/(]\*\\|<!--\) \(.*\) \(\*[/)]\\|-->\)$/\2/<CR> <Esc>:nohlsearch<CR>

" to clear hlsearch -- hit ,h to clear highlighting from last search
map ,h :nohlsearch <CR>
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" Syntax highliting for .x files
au BufRead,BufNewFile *.x set filetype=dotx
au BufRead,BufNewFile *.x set expandtab " .x files can't have tabs or else RPL complains
" au BufRead,BufNewFile *.x set foldmethod=marker " use {{{/}}} for folds
au BufRead,BufNewFile *.v set expandtab " .v files can't have tabs or else RPL complains
au BufRead,BufNewFile *.tpl set expandtab " .tpl files can't have tabs or else RPL complains
au! Syntax dotx source ~/dotxsyntax.vim

au BufRead,BufNewFile *.l set filetype=lex
au BufRead,BufNewFile *.sv set filetype=verilog_systemverilog
au BufRead,BufNewFile *.svh set filetype=verilog_systemverilog
au BufRead,BufNewFile *.svpl set filetype=verilog_systemverilog
au BufRead,BufNewFile *.sv set expandtab
au BufRead,BufNewFile *.svh set expandtab
au BufRead,BufNewFile *.svpl set expandtab
" au! BufRead,BufNewFile *.folded set foldmethod=marker

"au! Syntax verilog source ~/.vim/verilog_systemverilog.vim
au! Syntax verilog_systemverilog source  ~/.vim/indent/verilog_systemverilog.vim

au BufRead,BufNewFile *.out set filetype=out

" colorschemes
autocmd FileType dotx,verilog_systemverilog colorscheme torte
autocmd FileType c,cpp colorscheme elflord
autocmd FileType asm colorscheme darkblue

map Diff :VCSVimDiff
vmap :s :s/\%V
map! <C-Z><C-Z> <C-R><C-W>

" Use 5.7 version of ctags since it includes verilog support
nnoremap <silent> <F8> :TlistToggle <CR>
nnoremap <silent> <F10> :NERDTree <CR>
let NERDTreeShowBookmarks=1

"let loaded_perforce=1

" fix silly file writing
set nobackup       "no backup files
set nowritebackup  "only in case you don't want a backup file while editing
set noswapfile     "no swap files

"add numbers by default
set number
