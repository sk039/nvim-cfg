"
"if has('nvim-0.4.0') || has('patch-8.2.0750')
"    nnoremap <silent><nowait><expr> <C-f> translator#window#float#has_scroll() ? translator#window#float#scroll(1) : "\<C-f>"
"    nnoremap <silent><nowait><expr> <C-b> translator#window#float#has_scroll() ? translator#window#float#scroll(0) : "\<C-b>"
"    inoremap <silent><nowait><expr> <C-f> translator#window#float#has_scroll() ? "\<c-r>=translator#window#float#scroll(1)\<cr>" : "\<Right>"
"    inoremap <silent><nowait><expr> <C-b> translator#window#float#has_scroll() ? "\<c-r>=translator#window#float#scroll(0)\<cr>" : "\<Left>"
"    vnoremap <silent><nowait><expr> <C-f> translator#window#float#has_scroll() ? translator#window#float#scroll(1) : "\<C-f>"
"    vnoremap <silent><nowait><expr> <C-b> translator#window#float#has_scroll() ? translator#window#float#scroll(0) : "\<C-b>"
"endif
"

" Echo translation in the cmdline
nmap <silent> <Leader>tc <Plug>Translate
vmap <silent> <Leader>tc <Plug>TranslateV
" Display translation in a window
nmap <silent> <Leader>tw <Plug>TranslateW
vmap <silent> <Leader>tw <Plug>TranslateWV
" Replace the text with translation
nmap <silent> <Leader>tr <Plug>TranslateR
vmap <silent> <Leader>tr <Plug>TranslateRV
let g:translator_window_max_width=0.8
let g:translator_window_max_height=0.8
let g:translator_default_engines=['google', 'haici', 'youdao']
