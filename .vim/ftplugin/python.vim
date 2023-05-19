" Python
set formatoptions=cqro
set foldmethod=indent
nmap <F5> :w<Cr>:!clear && python %<Cr><Cr>
nmap <F6> :w<Cr>:!clear && ipython -i %<Cr><Cr>
