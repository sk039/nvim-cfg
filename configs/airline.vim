" airline config
let g:airline_theme='gruvbox'
let g:airline_section_z = "%p%%(%l/%L) Col:%c"

" airline tabline
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#buffer_min_count = 2
"let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
"let g:airline#extensions#tabline#buffer_idx_mode = 1
"nmap <leader>t1 <Plug>AirlineSelectTab1
"nmap <leader>t2 <Plug>AirlineSelectTab2
"nmap <leader>t3 <Plug>AirlineSelectTab3
"nmap <leader>t4 <Plug>AirlineSelectTab4
"nmap <leader>t5 <Plug>AirlineSelectTab5
"nmap <leader>t6 <Plug>AirlineSelectTab6
"nmap <leader>t7 <Plug>AirlineSelectTab7
"nmap <leader>t8 <Plug>AirlineSelectTab8
"nmap <leader>t9 <Plug>AirlineSelectTab9
"nmap <leader>t0 <Plug>AirlineSelectTab0
"nmap <leader>t- <Plug>AirlineSelectPrevTab
"nmap <leader>t+ <Plug>AirlineSelectNextTab

" https://stackoverflow.com/questions/59850403/the-meaning-of-the-status-bar-trailing-mixed-indent-mix-indent-file-in-vim
let g:airline#extensions#whitespace#enabled = 0
"
" airline coc
let g:airline#extensions#nvimlsp#enabled = 1
let g:airline#extensions#nvimlsp#error_symbol = 'E:'
let g:airline#extensions#nvimlsp#warning_symbol = 'W:'
