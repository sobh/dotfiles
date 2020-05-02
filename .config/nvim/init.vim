" vim: foldmethod=marker
" .vimrc
"

"---- Configure Plugins -----------------------------------------------------{{{
set nocompatible    " Be iMproved (Required)
filetype off

" vim-plug is located in $HOME/.vim/autoload/plug.vim
"Set the runtime path to include vim-plug and initialize.
call plug#begin('$HOME/.vim/plugged')
" Let vim-plug manage vim-plug
Plug 'junegunn/vim-plug'
"---- Plugs ------------------------------------------------------------------
"---- General Purpose ----------
Plug 'nathanaelkane/vim-indent-guides'	" Indent Guides
Plug 'majutsushi/tagbar'		" Source Code Outline
Plug 'scrooloose/nerdtree'		" File Explorer
Plug 'itchyny/lightline.vim'		" Status Line
"---- Editing ------------------
Plug 'tpope/vim-surround'		" Surrounded text
Plug 'tpope/vim-commentary'		" Comment code
"---- Syntax -------------------
Plug 'Glench/Vim-Jinja2-Syntax'		    " Python Jinja2
Plug 'Matt-Deacalion/vim-systemd-syntax'    " systemd syntax
Plug 'PotatoesMaster/i3-vim-syntax'	    " i3 wm Configuration
Plug 'cespare/vim-toml'			    " TOML
Plug 'gisphm/vim-gitignore'		    " Git Ignore
"---- Color Schemes ------------
Plug 'ap/vim-css-color'			" Preview colours in source code.
Plug 'tomasr/molokai'
Plug 'nanotech/jellybeans.vim'
" Plug 'altercation/vim-colors-solarized'
" Plug 'chriskempson/base16-vim'
" Plug 'flazz/vim-colorschemes'

"---- General Purpose --------------------------------------
"Plug 'xolox/vim-easytags'
"Plug 'xolox/vim-misc'
"Plug 'scrooloose/nerdcommenter'
"Plug 'scrooloose/syntastic'
" Plug 'tpope/vim-fugitive'
"Plug 'Shougo/neocomplete.vim'
"Plug 'Valloric/YouCompleteMe'
"Plug 'ervandew/supertab'
" Plug 'Lokaltog/vim-easymotion'
" Plug 'taglist.vim'
" Plug 'Raimondi/delimitMate'
" Plug 'Lokaltog/vim-powerline'
" Edit GNUPG encrypted files
" Plug 'jamessan/vim-gnupg'
"Plug 'kien/rainbow_parentheses.vim'
"---- Language Specific ------------------------------------
" C
"Plug 'vim-scripts/gtk-vim-syntax'
" Dart
" Plug 'dart-lang/dart-vim-plugin'
"---- HTML/XML
"Plug 'alvan/vim-closetag'
"Plug 'mattn/emmet-vim'
"Plug 'tpope/vim-surround'
"---- Javascript
" Plug 'jelera/vim-javascript-syntax'
" Plug 'pangloss/vim-javascript'
" Python
" Plug 'davidhalter/jedi-vim'
" Typescript
" Plug 'leafgarland/typescript-vim'
" Plug 'HerringtonDarkholme/yats.vim'
" Plug 'Quramy/tsuquyomi'

" Initialize plugin system
call plug#end()
"}}}

filetype indent on    " required

"---- General ---------------------------------------------------------------{{{
"Cursor settings:
"  1 -> blinking block
"  2 -> solid block
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar
let &t_SI="\e[5 q" "SI = INSERT mode
let &t_SR="\e[4 q" "SR = REPLACE mode
let &t_EI="\e[2 q" "EI = NORMAL mode (ELSE)
" Always start in Normal Mode
silent !echo -ne "\e[2 q"

set autoindent		" Autoindent
set cursorline		" Highlight current line
set encoding=utf-8	" Set UTF-8
set hidden		" Enable hidden buffers
set hlsearch		" Highlight Searched Words
set incsearch		" Incremental Search
set mouse=a		" Enable Mouse for all modes
set number		" Show line numbers
set relativenumber	" Show line numbers relative to current line
set showcmd		" Show Command being typed
"set spell spelllang=en_us	" English Spell Check
set fileformat=unix	" Unix File Format
"---- Format -------------------------------------------------------------------
" Tabs
set tabstop=8		" Number of spaces of the <Tab>
set shiftwidth=8	" Number of spaces for indents ('cinednt', '<<', '>>')
set noexpandtab		" Do not expands <Tab> into spaces
set softtabstop=4	" Number of space of <Tab> while editing

set foldcolumn=8	" Set Folding
set foldmethod=syntax	" Default foldmethod
set formatoptions+=c	" Format Options
set textwidth=80	" Set Text width
set colorcolumn=+1      " Highlight end of text width
set nowrap		" Disable line wrapping
set ignorecase		" Ignore case in search patterns
set smartcase		" Override 'ignorecase' if search pattern has uppercase

set listchars=tab:\├─➜,space:·	" String to use in 'list' mode

"---- Colorscheme --------------------------------------------------------------
set background=dark
if &term !=? 'linux'
	let g:molokai_original = 1
	let g:rehash256 = 1
	colorscheme molokai
endif
syntax on		" Set syntax highlighting
" let g:solarized_termcolors=256
" colorscheme solarized
" let base16colorspace=256  " Access colors present in 256 colorspace
" colorscheme base16-default

"---- Highlight and Remove Trailing Space --------------------------------------
" highlight ExtraWhitespace ctermbg=red guibg=red
" match ExtraWhitespace /\s\+$/
autocmd BufWritePre * :%s/\s\+$//e

" }}}

"---- Plugin Options --------------------------------------------------------{{{
"---- Indent Guides --------------------
let g:indent_guides_guide_size=1
let g:indent_guides_start_level=2
let g:indent_guides_enable_on_vim_startup = 1
"---- Status Bar (lightline) ---
set laststatus=2
set noshowmode	    " No need to show mode
"---- Syntastic ------------------------
" let g:syntastic_cpp_compiler = 'g++'
" let g:syntastic_cpp_compiler_options = ' -std=c++11'
"---- GNUPG ----------------------------
let g:GPGPreferSymmetric=1

"---- Rainbo Parenthesese ----------------------------------
" " Enable Rainbow Parentheses
" au VimEnter * RainbowParenthesesToggle
" au Syntax * RainbowParenthesesLoadRound
" au Syntax * RainbowParenthesesLoadSquare
" au Syntax * RainbowParenthesesLoadBraces

"---- HTML/XML ---------------------------------------------
"inoremap <C-_> <C-R>=GetCloseTag()<CR><ESC>%i

"source $HOME/.vim/scripts/config-neocomplete.vim
" }}}

"---- Mappings --------------------------------------------------------------{{{
let mapleader=" "	" Set <Leader> to space
" Save n Run
noremap  <F2>            :w<CR>:!clear; ./%<CR>
inoremap <F2>       <Esc>:w<CR>:!clear; ./%<CR>
" NERDTree
noremap  <F11>            :NERDTreeToggle<CR>
inoremap <F11>       <Esc>:NERDTreeToggle<CR>
" Taglist
noremap  <F12>            :TagbarToggle<CR>
inoremap <F12>       <Esc>:TagbarToggle<CR>

" Substitute word under cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
" Switch between recent buffers with Shift+Tab
noremap  <S-Tab>          :b#<CR>

" Edit and resouce $HOME/.vimrc
nnoremap <leader>ev       :vsplit $MYVIMRC<CR>
nnoremap <leader>sv       :source $MYVIMRC<CR>
" Faster Insert -> Normal Transitions
"inoremap <esc>            <nop>
inoremap jk               <esc>

" }}}
