" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2006 Nov 16
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Terminal setting
if &term =~ "xterm"
    if has("terminfo")
        set t_Co=8
        set t_Sf=[3%p1%dm
        set t_Sb=[4%p1%dm
    else
        set t_Co=8
        set t_Sf=[3%dm
        set t_Sb=[4%dm
    endif
endif


" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" In many terminal emulators the mouse works just fine, thus enable it.
set mouse=a


" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Color settings
"   Only 8 colors available:
"   Black/White/Blue/LightRed/DarkRed/LightGreen/DarkGreen/
"
set background=dark

"highlight Normal      ctermfg=White         cterm=standout
highlight Comment     ctermfg=Green 
"highlight Statement  ctermfg=White      ctermbg=LightGreen     cterm=standout  
"highlight StatusLine  ctermfg=White         ctermbg=DarkGreen   cterm=NONE
"highlight User1       ctermfg=White         ctermbg=DarkGreen   cterm=NONE
"highlight LineNr      ctermfg=Red
"highlight Visual      ctermfg=White         ctermbg=LightRed
"highlight Search      ctermfg=White         ctermbg=LightRed
"highlight Cursor      ctermfg=Black         ctermbg=Green      


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
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else


endif " has("autocmd")

set autoindent		" always set autoindenting on
set nu

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
	 	\ | wincmd p | diffthis

" no backup setting
set nobackup
set nowritebackup


source ~/.vim/my.vim
" call pathogen#infect()
