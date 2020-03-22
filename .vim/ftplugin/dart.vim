let g:indent_guides_guide_size=2
set expandtab
set tabstop=2
set shiftwidth=2

" Save file and execute it.
nmap <F2> :w<Cr>:!clear && dart %<Cr>
imap <F2> <Esc>:w<Cr>:!clear && dart %<Cr>
