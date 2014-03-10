" File:		.vimrc
"
" Purpose:	Define my VIm settings.
"
" Author:	Mohamed Sobh
" Created:	2010-09-07
" Modified:	2010-12-16
"


"""" Configure vundle """"""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible		" Be iMproved (Required)
filetype off
"Set the runtime path to include Vundle and initialize.
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
" Let Vundle manage Vundle (Required)
Bundle 'gmarik/vundle'
"""" Plugins """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Note: Don't put comments in the same line as the Bundle command, it will cause
" error E116: Invalid arguments for function vundle#config#bundle. Somehow the
" comment would be interpreted as an argument.
"""" GitHub repos
" Port of the Monokai theme for TextMate
Bundle 'tomasr/molokai'
" Keep bundle commands between here and filetype plugin indent on.
filetype plugin indent on	" Required for vundle.
" To ignore plugin indent changes use:
" filetype plugin on
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Turn-on spelling checker, and set language to English(US)
"set spell spelllang=en_us

" Set syntax highlighting
syntax on
" Highlight current line
set cursorline
" Set highlighting color theme
set background=dark
colorscheme molokai

" Enable hidden buffers
set hidden
" Show line numbers
set number
" Incremental Search
set incsearch
" Unix File Format
set fileformat=unix
" Show Command being typed
set showcmd
" Autoindent
set autoindent
" Enale Filetype Plugins
filetype plugin on
" Set Text width
set textwidth=80
" Set Folding
set foldcolumn=8
set foldmethod=syntax 
" Format Options
set formatoptions+=c

				  " Mappings "
nmap	<F12>		:set arabic!<CR>
" Switch between recent buffers with Shift+Tab
nmap	<S-Tab>		:b#<CR>

				" Autocommands "
" C/C++ files {{{1
augroup cfiles
	autocmd BufReadPre *.c,*.cpp,*.h let c_curly_error=1
	autocmd BufEnter *.c,*.cpp,*.h set cindent formatoptions=cqro
	set cinoptions+=:0
augroup END

" Java Files
augroup javafiles
	autocmd BufEnter *.java set cindent formatoptions=cqro
	set cinoptions+=:0
augroup END
" Python
augroup pyfiles
	autocmd BufEnter *.py set autoindent formatoptions=cqro
	" Execute the Current buffer in bash
	nmap <F2> :w<Cr>:!./%<Cr>
augroup END

" TeX files
augroup tex
	autocmd BufReadPre	*.tex	let tex_fold_enabled=1
	autocmd BufEnter	*.tex	set autoindent formatoptions=tcqro
augroup END
