"
" Purpose:	Define VIm settings.
"

"---- Configure vundle ---------------------------------------------------------
set nocompatible		" Be iMproved (Required)
filetype off
"Set the runtime path to include Vundle and initialize.
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Let Vundle manage Vundle (Required)
Plugin 'gmarik/Vundle.vim'
"---- Plugins ------------------------------------------------------------------
" Note: Don't put comments in the same line as the Plugin command, it will cause
" error E116: Invalid arguments for function vundle#config#bundle. Somehow the
" comment would be interpreted as an argument.
" Keep Plugin commands between vundle#begin/end.
"---- General Purpose --------------------------------------
Plugin 'scrooloose/nerdtree'
" Plugin 'Lokaltog/vim-easymotion'
" Plugin 'taglist.vim'
" Plugin 'Raimondi/delimitMate'
Plugin 'bling/vim-airline'
" Plugin 'Lokaltog/vim-powerline'
" Edit GNUPG encrypted files
Plugin 'jamessan/vim-gnupg'
Plugin 'kien/rainbow_parentheses.vim'
"---- Language Specific ------------------------------------
" Python
Plugin 'davidhalter/jedi-vim'
" HTML/XML
" Plugin 'docunext/closetag.vim'
" Plugin 'mattn/emmet-vim'
"---- Color Schemes ----------------------------------------
Plugin 'tomasr/molokai'
Plugin 'nanotech/jellybeans.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'chriskempson/base16-vim'
" Plugin 'flazz/vim-colorschemes'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
"-------------------------------------------------------------------------------
syntax on		" Set syntax highlighting
set autoindent		" Autoindent
set cursorline		" Highlight current line
set encoding=utf-8	" Set UTF-8
set hidden		" Enable hidden buffers
set hlsearch		" Highlight Searched Words
set incsearch		" Incremental Search
set mouse=a		" Enable Mouse for all modes
set number		" Show line numbers
set showcmd		" Show Command being typed
set spell spelllang=en_us	" English Spell Check
"set fileformat=unix	" Unix File Format
"---- Format -------------------------------------------------------------------
set foldcolumn=8	" Set Folding
set foldmethod=syntax	" Default foldmethod 
set formatoptions+=c	" Format Options
set textwidth=80	" Set Text width
set colorcolumn=+1      " Highlight end of text width
set nowrap		" Disable line wrapping

"---- Colorscheme --------------------------------------------------------------
"set t_Co=256
set background=dark
" let g:molokai_original = 1
" let g:rehash256 = 1
" colorscheme molokai
" let g:solarized_termcolors=256
" colorscheme solarized
" let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-default

"---- Plugin Options -----------------------------------------------------------
"---- Airline ----------------------------------------------
set laststatus=2
let g:airline_powerline_fonts=1
"---- Rainbo Parenthesese ----------------------------------
" Enable Rainbow Parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
"---- GNUPG ------------------------------------------------
let g:GPGPreferSymmetric=1

"---- HTML/XML ---------------------------------------------
"inoremap <C-_> <C-R>=GetCloseTag()<CR><ESC>%i

"---- Mappings -----------------------------------------------------------------
" Switch between recent buffers with Shift+Tab
nmap	<S-Tab>		:b#<CR>
" NERDTree
map	<F11>		:NERDTreeToggle<CR>
nmap	<F11>		<Esc>:NERDTreeToggle<CR>
" Taglist
map	<F12>		:TlistToggle<CR>
nmap	<F12>		<Esc>:TlistToggle<CR>

				" Autocommands "
"---- Autocommand --------------------------------------------------------------
if has("autocmd")
	" Markdown
	augroup markdown
		autocmd!
		autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
	augroup END
end
