
	" C/C++
	augroup cfiles
		autocmd!
		autocmd BufReadPre *.c,*.cpp,*.h let c_curly_error=1
		autocmd BufEnter *.c,*.cpp,*.h set cindent formatoptions=cqro
		set cinoptions+=:0
	augroup END
