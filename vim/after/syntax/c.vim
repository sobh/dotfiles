" Vim syntax file appendix
" Language:		C
" Author:		Mohamed Sobh <momu0701@student.miun.se>
" Date Created:		2010-09-10
" Last Modified:	2010-09-17 17:52
"

" Enable fold for conditional compilation
"syn region	hBlock	start="^\s*#if\(def\|ndef\)\?\>" end="^#endif\>" fold keepend transparent
"syn region	hBlock	start="^.*\({{{\|@{\|(((\).*$" end="^.*\(}}}\|@}\|)))\).*$" transparent fold contained
"syn region	gBlock	start="^.*((($" end="^.*)))" fold contained
"syn cluster	Comment	contains=gBlock

			    " Statment Definitions "
" Operators
syntax match	cOperator	"[;\-+\*\/%<>=&|\^~!\.,?:]" contains=TOP
"syntax region	cHBlock matchgroup=cHParen	start='[{\[(]' end='[}\])]' contains=ALLBUT,@cParenGroup,cCppParen,cErrInBracket,cCppBracket,cCppString,@Spell
" Create Links
hi def link	cOperator	Operator
"hi cHParen	cterm=Bold


" AVR32 Framework
if exists("c_avr32")
	source $HOME/.vim/after/syntax/avr32.vim
endif

" Qt Framework
if exists("c_qt")
	source $HOME/.vim/after/syntax/qt.vim
endif
