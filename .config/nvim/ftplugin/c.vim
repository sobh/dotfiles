" Save -> Compile -> Run
noremap  <F2>            :w<CR>:!clear; gcc % -o %.out; ./%.out; rm %.out<CR>
inoremap <F2>       <Esc>:w<CR>:!clear; gcc % -o %.out; ./%.out; rm %.out<CR>

let c_curly_error=1
set cindent formatoptions=cqro
set cinoptions+=:0
