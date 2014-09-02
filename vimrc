"
" Purpose:	Define VIm settings.
"

"""" Configure vundle """"""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible		" Be iMproved (Required)
filetype off
"Set the runtime path to include Vundle and initialize.
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Let Vundle manage Vundle (Required)
Plugin 'gmarik/Vundle.vim'
"""" Plugins """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Note: Don't put comments in the same line as the Plugin command, it will cause
" error E116: Invalid arguments for function vundle#config#bundle. Somehow the
" comment would be interpreted as an argument.
" Keep Plugin commands between vundle#begin/end.
"""" GitHub repos
Plugin 'scrooloose/nerdtree'
" Plugin 'Lokaltog/vim-easymotion'
" Plugin 'taglist.vim'
" Plugin 'Raimondi/delimitMate'
Plugin 'bling/vim-airline'
" Plugin 'Lokaltog/vim-powerline'
" Edit GNUPG encrypted files
Plugin 'jamessan/vim-gnupg'
" HTML/XML
" Plugin 'docunext/closetag.vim'
" Plugin 'mattn/emmet-vim'
" Syntax
Plugin 'kien/rainbow_parentheses.vim'
" Color Schemes
Plugin 'tomasr/molokai'
Plugin 'nanotech/jellybeans.vim'
Plugin 'altercation/vim-colors-solarized'
" Plugin 'chriskempson/base16-vim'
" Plugin 'flazz/vim-colorschemes'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

inoremap <C-_> <C-R>=GetCloseTag()<CR><ESC>%i


" Turn-on spelling checker, and set language to English(US)
"set spell spelllang=en_us

" Set syntax highlighting
syntax on
" Highlight current line
set cursorline
" Set highlighting color theme
set t_Co=256
set background=dark
" let g:molokai_original = 1
" let g:rehash256 = 1
colorscheme molokai
" let g:solarized_termcolors=256
" colorscheme solarized
" let base16colorspace=256  " Access colors present in 256 colorspace
" colorscheme base16-3024

" Enable Mouse for all modes
set mouse=a
" Enable hidden buffers
set hidden
" Show line numbers
set number
" Incremental Search
set incsearch
" Highlight Searched Words
set hlsearch
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

" Enable Rainbow Parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" GNUPG
let g:GPGPreferSymmetric=1
" Airline
set laststatus=2
let g:airline_powerline_fonts=1

				  " Mappings "
" Switch between recent buffers with Shift+Tab
nmap	<S-Tab>		:b#<CR>
" NERDTree
map	<F11>		:NERDTreeToggle<CR>
nmap	<F11>		<Esc>:NERDTreeToggle<CR>
" Taglist
map	<F12>		:TlistToggle<CR>
nmap	<F12>		<Esc>:TlistToggle<CR>

				" Autocommands "
if has("autocmd")
	" C/C++
	augroup cfiles
		autocmd!
		autocmd BufReadPre *.c,*.cpp,*.h let c_curly_error=1
		autocmd BufEnter *.c,*.cpp,*.h set cindent formatoptions=cqro
		set cinoptions+=:0
	augroup END
	" Markdown
	augroup markdown
		autocmd!
		autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
	augroup END

	" Java Files
	augroup javafiles
		autocmd!
		autocmd BufEnter *.java set cindent formatoptions=cqro
		set cinoptions+=:0
	augroup END
	" Python
	augroup pyfiles
		autocmd!
		autocmd BufEnter *.py set autoindent formatoptions=cqro
		" Execute the Current buffer in bash
		nmap <F2> :w<Cr>:!./%<Cr>
	augroup END

	" TeX files
	augroup tex
		autocmd BufReadPre	*.tex	let tex_fold_enabled=1
		autocmd BufEnter	*.tex	set autoindent formatoptions=tcqro
	augroup END
endif
