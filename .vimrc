" vim: foldmethod=marker
" .vimrc
"

"---- Configure Plugins -----------------------------------------------------{{{
set nocompatible    " Be iMproved (Required)
filetype off

" Auto install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" vim-plug is located in $HOME/.vim/autoload/plug.vim
" Set the runtime path to include vim-plug and initialize.
call plug#begin('$HOME/.vim/plugged')
" Let vim-plug manage vim-plug
Plug 'junegunn/vim-plug'
"---- Plugs --------------------------------------------------------------------
"-------- UI --------------------------
Plug 'nathanaelkane/vim-indent-guides'  " Indent Guides
Plug 'majutsushi/tagbar',              { 'on': 'TagbarToggle' }
Plug 'scrooloose/nerdtree',            { 'on': 'NERDTreeToggle' }
Plug 'itchyny/lightline.vim'            " Status Line
"-------- Syntax ----------------------
Plug 'ap/vim-css-color'                 " Preview colours in source code.
Plug 'jaxbot/semantic-highlight.vim'    " Different Color for each word
Plug 'Valloric/vim-operator-highlight'  " Highlight Operator Characters
Plug 'luochen1990/rainbow'              " Rainbow Parentheses
Plug 'PotatoesMaster/i3-vim-syntax'     " i3 wm Configuration
Plug 'gisphm/vim-gitignore'             " Git Ignore
Plug 'mechatroner/rainbow_csv'          " CSV Rainbow Fields
"-------- Color Schemes ---------------
Plug 'tomasiser/vim-code-dark'         " VS Code
Plug 'dunstontc/vim-vscode-theme'      " VS Code +
Plug 'rafi/awesome-vim-colorschemes'
" Plug 'tomasr/molokai'
" Plug 'nanotech/jellybeans.vim'
" Plug 'altercation/vim-colors-solarized'
" Plug 'chriskempson/base16-vim'
" Plug 'flazz/vim-colorschemes'
"-------- LSP -------------------------
"-------- Editing ---------------------
Plug 'sobh/vim-stabs'                       " Tabs for indents, Spaces for alignment
Plug 'tpope/vim-commentary'                 " Comment code
Plug 'easymotion/vim-easymotion'            " Easy Motion
Plug 'junegunn/vim-easy-align'              " Text Alignment
Plug 'Glench/Vim-Jinja2-Syntax'             " Python Jinja2
Plug 'Matt-Deacalion/vim-systemd-syntax'    " systemd syntax
Plug 'cespare/vim-toml'                     " TOML
" Plug 'tpope/vim-surround'            " Surrounded text
" Plug 'vim-python/python-syntax'                " Python
" Python Semantic Highlighting
"Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
"-------- Last ------------------------
" Adds file type icons to Vim plugins
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Faster alternative to 'tiagofumo/vim-nerdtree-syntax-highlight'
" Plug 'vwxyutarooo/nerdtree-devicons-syntax'

"---- General Purpose --------------------------------------
"Plug 'xolox/vim-easytags'
"Plug 'xolox/vim-misc'
"Plug 'scrooloose/nerdcommenter'
"Plug 'scrooloose/syntastic'
"Plug 'tpope/vim-fugitive'
"Plug 'Shougo/neocomplete.vim'
"Plug 'ervandew/supertab'
" Plug 'Lokaltog/vim-easymotion'
" Plug 'taglist.vim'
" Plug 'Raimondi/delimitMate'
" Edit GNUPG encrypted files
" Plug 'jamessan/vim-gnupg'
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
call plug#load('vim-devicons')
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

" set conceallevel=3
set autoindent                    " Autoindent
set cursorline                    " Highlight current line
set encoding=UTF-8                " Set UTF-8
set hidden                        " Enable hidden buffers
set hlsearch                      " Highlight Searched Words
set incsearch                     " Incremental Search
set mouse=a                       " Enable Mouse for all modes
set number                        " Show line numbers
set relativenumber                " Show line numbers relative to current line
set showcmd                       " Show Command being typed
"set spell spelllang=en_us        " English Spell Check
set fileformat=unix               " Unix File Format
"---- Format -------------------------------------------------------------------
" Tabs
set tabstop=8            " Number of spaces of the <Tab>
set shiftwidth=8         " Number of spaces for indents ('cinednt', '<<', '>>')
set noexpandtab          " Do not expands <Tab> into spaces
set softtabstop=8        " Number of space of <Tab> while editing

set foldcolumn=8         " Set Folding Column width
set foldmethod=syntax    " Default foldmethod
set formatoptions+=c     " Format Options
set textwidth=80         " Set Text width
set colorcolumn=+1       " Highlight end of text width
set nowrap               " Disable line wrapping
set ignorecase           " Ignore case in search patterns
set smartcase            " Override 'ignorecase' if search pattern has uppercase

"---- UI -----------------------------------------------------------------------
set listchars=tab:\├─>,space:·      " String to use in 'list' mode
set fillchars=vert:│            " Use Vertical Box Drawing for vertical seperator
"---- Colorscheme --------------------------------------------------------------
set background=dark
if &term !=? 'linux'
	set termguicolors
	let g:t_Co=256
	" let g:molokai_original=1
	colorscheme molokai
	" let g:rehash256 = 1
	" colorscheme codedark
endif
" Enable Syntax Highlighting
syntax enable

"---- Highlight and Remove Trailing Space --------------------------------------
" highlight ExtraWhitespace ctermbg=red guibg=red
" match ExtraWhitespace /\s\+$/
function! StripTrailingWhiteSpace()
	" Don't strip on these filetypes
	if &filetype =~ 'tsv'
		return
	endif
	:%s/\s\+$//e
endfunction
autocmd BufWritePre * call StripTrailingWhiteSpace()

" }}}

"---- Plugin Options --------------------------------------------------------{{{
"-------- Stabs ------------------------
let g:stabs_align_width=4
"-------- Easy Align -------------------
" Start interactive EasyAlign in visual mode (e.g. vipga)
xnoremap ga <Plug>(LiveEasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nnoremap ga <Plug>(LiveEasyAlign)

"-------- Rainbo Parenthesese ----------
let g:rainbow_active=1
autocmd VimEnter * RainbowToggleOn
"-------- TagBar -----------------------
let g:tagbar_iconchars = ['►', '▼ ']
"-------- NERDTree ----------
" NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Folder Characters
" let g:NERDTreeDirArrowExpandable = ''         " 📁
" let g:NERDTreeDirArrowCollapsible = ''        " 📂
"-------- DevIcons ---------------------
let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = '📁' "   
let g:DevIconsDefaultFolderOpenSymbol = '📂'                    "   
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['html'] = ''
" Fix brackets around icons
autocmd VimEnter * syntax enable | call webdevicons#refresh()
"-------- Operator Highlight -----------
let g:ophigh_highlight_link_group='Operator'
"-------- Indent Guides ---------------
let g:indent_guides_guide_size=1
let g:indent_guides_start_level=2
let g:indent_guides_enable_on_vim_startup = 1
"-------- Status Bar - lightline -------
set laststatus=2
set noshowmode          " No need to show mode as lightline shows it on the left
"-------- GNUPG ------------------------
let g:GPGPreferSymmetric=1



"-------- HTML/XML ---------------------
"inoremap <C-_> <C-R>=GetCloseTag()<CR><ESC>%i

"-------- Python ----------------------
let g:python_highlight_all=1
"source $HOME/.vim/scripts/config-neocomplete.vim
" }}}

"---- Mappings --------------------------------------------------------------{{{
let mapleader=" "      " Set <Leader> to space
" Save n Run
noremap  <F2>             :w<CR>:!clear; %:p<CR>
inoremap <F2>        <Esc>:w<CR>:!clear; %:p<CR>
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
inoremap jj               <esc>

" }}}
