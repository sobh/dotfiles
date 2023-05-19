" avr32.vim
"
" Purpose:	Set VIm to be used for editing the Sentio32 Project
"
" Author:	Mohamed Sobh <momu0701@student.miun.se>
" Date:			2010-09-07
" Last Modified:	2010-09-12
"

" Enable AVR32 Framework C-syntax. 
syntax on

" Automatically save files
set autowrite
set autowriteall

" Add CScope files.
" The AVR32 Header Files
cscope add $HOME/oshw/launchpad/cscope/cscope.out $HOME/oshw/launchpad/cscope/

" Load Cscope Maps
source $HOME/.vim/scripts/cscope_maps.vim

"" Add directories to search path
set path+=/usr/msp430/include/**
				 " Functions "

" Purpose:	Easily switch between source, and header file
function! SwitchSourceHeader()
	if (expand("%:e") == "c")
		find %:t:r.h
	else
		find %:t:r.c
	endif
endfunction

				  " Mappings "

nmap <F4> :call SwitchSourceHeader()<CR> 
nmap <F3> :b#<CR>
