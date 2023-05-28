" vim: foldmethod=marker
"

"---- General ---------------------------------------------------------------{{{
"Cursor settings:
"  1 -> blinking block
"  2 -> solid block
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar
" let &t_SI="\e[5 q" "SI = INSERT mode
" let &t_SR="\e[4 q" "SR = REPLACE mode
" let &t_EI="\e[2 q" "EI = NORMAL mode (ELSE)
" " Always start in Normal Mode
" silent !echo -ne "\e[2 q"

" set conceallevel=3
set autoindent		" Autoindent
set cursorline		" Highlight current line
set encoding=UTF-8	" Set UTF-8
set hidden		" Enable hidden buffers
set showcmd		" Show Command being typed
"set spell spelllang=en_us	" English Spell Check
set fileformat=unix	" Unix File Format
"---- Format -------------------------------------------------------------------
set formatoptions+=c	" Format Options
set nowrap		" Disable line wrapping

"---- UI -----------------------------------------------------------------------
set listchars=tab:\├─>,space:·	" String to use in 'list' mode
set fillchars=vert:│		" Use Vertical Box Drawing for vertical seperator


"---- Highlight and Remove Trailing Space --------------------------------------
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
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
"-------- TagBar -----------------------
let g:tagbar_iconchars = ['►', '▼ ']
"-------- NERDTree ----------
" NERDTree automatically when vim starts up on opening a directory
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" Close vim if the only window left open is a NERDTree
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Folder Characters
" let g:NERDTreeDirArrowExpandable = ''	" 📁
" let g:NERDTreeDirArrowCollapsible = ''		" 📂
"-------- DevIcons ---------------------
let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ''	" 
let g:DevIconsDefaultFolderOpenSymbol = ''			" 
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['html'] = ''
" Fix brackets around icons
" autocmd VimEnter * syntax enable | call webdevicons#refresh()
"-------- Operator Highlight -----------
let g:ophigh_highlight_link_group='Operator'
"-------- Indent Guides ---------------
let g:indent_guides_guide_size=1
let g:indent_guides_start_level=2
let g:indent_guides_enable_on_vim_startup = 1
"-------- GNUPG ------------------------
let g:GPGPreferSymmetric=1



" }}}

"---- Mappings --------------------------------------------------------------{{{
" Substitute word under cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
" }}}
