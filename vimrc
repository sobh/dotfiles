"
" .vimrc
"

"---- Configure vundle ------------------------------------------------------{{{
set nocompatible		" Be iMproved (Required)
filetype off

" vim-plug is located in ~/.vim/autoload/plug.vim
"Set the runtime path to include vim-plug and initialize.
call plug#begin('~/.vim/plugged')
" Let vim-plug manage vim-plug
Plug 'junegunn/vim-plug'
"---- Plugs ------------------------------------------------------------------
"---- General Purpose --------------------------------------
"Plug 'xolox/vim-easytags'
"Plug 'xolox/vim-misc'
Plug 'nathanaelkane/vim-indent-guides'
"Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
"Plug 'scrooloose/syntastic'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-fugitive'
"Plug 'Shougo/neocomplete.vim'
"Plug 'Valloric/YouCompleteMe'
"Plug 'ervandew/supertab'
" Plug 'Lokaltog/vim-easymotion'
" Plug 'taglist.vim'
" Plug 'Raimondi/delimitMate'
Plug 'bling/vim-airline'
" Plug 'Lokaltog/vim-powerline'
" Edit GNUPG encrypted files
Plug 'jamessan/vim-gnupg'
"Plug 'kien/rainbow_parentheses.vim'
"---- Language Specific ------------------------------------
" C++
Plug 'Townk/vim-qt'
" C
"Plug 'vim-scripts/gtk-vim-syntax'
" Dart
Plug 'dart-lang/dart-vim-plugin'
" HTML/XML
Plug 'alvan/vim-closetag'
Plug 'mattn/emmet-vim'
"Plug 'tpope/vim-surround'
" i3 wm Configuration
Plug 'PotatoesMaster/i3-vim-syntax'
" Javascript
"Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'
" nim
Plug 'zah/nim.vim'
" Python
Plug 'davidhalter/jedi-vim'
Plug 'Glench/Vim-Jinja2-Syntax'
" Typescript
Plug 'leafgarland/typescript-vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'Quramy/tsuquyomi'
"---- Color Schemes ----------------------------------------
Plug 'tomasr/molokai'
Plug 'nanotech/jellybeans.vim'
" Plug 'altercation/vim-colors-solarized'
" Plug 'chriskempson/base16-vim'
" Plug 'flazz/vim-colorschemes'

" Initialize plugin system
call plug#end()

filetype indent on    " required
"}}}

"---- General ---------------------------------------------------------------{{{
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
"set spell spelllang=en_us	" English Spell Check
set fileformat=unix	" Unix File Format
"---- Format -------------------------------------------------------------------
set foldcolumn=8	" Set Folding
set foldmethod=syntax	" Default foldmethod
set formatoptions+=c	" Format Options
set textwidth=120	" Set Text width
set colorcolumn=+1      " Highlight end of text width
set nowrap		" Disable line wrapping

"---- Colorscheme --------------------------------------------------------------
set t_Co=256
set background=dark
let g:molokai_original = 1
let g:rehash256 = 1
colorscheme molokai
" let g:solarized_termcolors=256
" colorscheme solarized
" let base16colorspace=256  " Access colors present in 256 colorspace
" colorscheme base16-default

"---- Highlight and Remove Trailing Space --------------------------------------
"highlight ExtraWhitespace ctermbg=red guibg=red
"match ExtraWhitespace /\s\+$/
autocmd BufWritePre * :%s/\s\+$//e

" }}}

"---- Plugin Options --------------------------------------------------------{{{
"---- Indent Guides ----------------------------------------
let g:indent_guides_guide_size=1
let g:indent_guides_start_level=2
let g:indent_guides_enable_on_vim_startup = 1
"---- Airline ----------------------------------------------
set laststatus=2
let g:airline_powerline_fonts=1

"---- Syntastic --------------------------------------------
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++11'
"---- Rainbo Parenthesese ----------------------------------
" " Enable Rainbow Parentheses
" au VimEnter * RainbowParenthesesToggle
" au Syntax * RainbowParenthesesLoadRound
" au Syntax * RainbowParenthesesLoadSquare
" au Syntax * RainbowParenthesesLoadBraces
"---- GNUPG ------------------------------------------------
let g:GPGPreferSymmetric=1

"---- HTML/XML ---------------------------------------------
"inoremap <C-_> <C-R>=GetCloseTag()<CR><ESC>%i

"source ~/.vim/scripts/config-neocomplete.vim
" }}}

"---- Mappings --------------------------------------------------------------{{{
" Substitute word under cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
" Switch between recent buffers with Shift+Tab
noremap  <S-Tab>          :b#<CR>
" NERDTree
noremap  <F11>            :NERDTreeToggle<CR>
inoremap <F11>       <Esc>:NERDTreeToggle<CR>
" Taglist
noremap  <F12>            :TagbarToggle<CR>
inoremap <F12>       <Esc>:TagbarToggle<CR>

" From Learn Vim The Hard Way
" Edit and resouce ~/.vimrc
nnoremap <leader>ev       :vsplit $MYVIMRC<cr>
nnoremap <leader>sv       :source $MYVIMRC<cr>
" Faster Insert -> Normal Transitions
"inoremap <esc>            <nop>
inoremap jk               <esc>

" }}}
