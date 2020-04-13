" File:		comment.vim
" Pupose:	Add, and remove comments to source file
"
" Author:	Mohamed Sobh
" 
" Created:	2010-12-17
" Modified:	2010-12-17
" 

if exists("loaded_comment_plugin")
	finish
end

let load_comment_plugin="Loaded Comment Plugin"

map <C-C> :call Comment()<Cr>

function! Comment()
	let file_ex=expand("%:e")
	" Find Appropiate Comment Character
	if file_ex == 'c' || file_ex == 'cpp' || file_ex == 'h'
		let cc='\/\/'
	elseif file_ex == "vim" " Vim Scripts
		let cc='"'
	else	" All Other Files
		let cc='#'
	endif
	let line = getline(".")
	" Check if the Line is already Commented, or Not
	if match(line, '^\s*'.cc) >= 0
		execute 's/\(^\s*\)\@<='.cc.'//'
	else
		execute 's/^/'.cc.'/'
	endif 
endfunction


