let timeoutlen=500
let g:which_key_align_by_seperator = 1
let g:which_key_floating_relative_win = 1
let g:which_key_map =  {}
"let g:which_key_map.t = {
"	  \ 'name' : '+Airline-Tab-Select' ,
"	  \ '1'  : ['<Plug>AirlineSelectTab1'         ,   'Airline Tab 1']        ,
"	  \ '2'  : ['<Plug>AirlineSelectTab2'         ,   'Airline Tab 2']        ,
"	  \ '3'  : ['<Plug>AirlineSelectTab3'         ,   'Airline Tab 3']        ,
"	  \ '4'  : ['<Plug>AirlineSelectTab4'         ,   'Airline Tab 4']        ,
"	  \ '5'  : ['<Plug>AirlineSelectTab5'         ,   'Airline Tab 5']        ,
"	  \ '6'  : ['<Plug>AirlineSelectTab6'         ,   'Airline Tab 6']        ,
"	  \ '7'  : ['<Plug>AirlineSelectTab7'         ,   'Airline Tab 7']        ,
"	  \ '8'  : ['<Plug>AirlineSelectTab8'         ,   'Airline Tab 8']        ,
"	  \ '9'  : ['<Plug>AirlineSelectTab9'         ,   'Airline Tab 9']        ,
"	  \ }
call which_key#register('\', "g:which_key_map")
nnoremap <silent> <leader> :WhichKey '\'<CR>
