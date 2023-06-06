" vimtex
"set conceallevel=2
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode = 0
let g:vimtex_view_automatic = 0

let g:vimtex_compiler_latexmk_engines = {
			\ '_'                : '-xelatex -xelatex="xelatex -synctex=1 -shell-escape %O %S"',
			\ 'pdflatex'         : '-pdf',
			\ 'dvipdfex'         : '-pdfdvi',
			\ 'lualatex'         : '-lualatex',
			\ 'xelatex'          : '-xelatex -xelatex="xelatex -shell-escape %O %S"',
			\ 'context (pdftex)' : '-pdf -pdflatex=texexec',
			\ 'context (luatex)' : '-pdf -pdflatex=context',
			\ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
			\}

" https://newptcai.gitlab.io/blog/vim-and-latex/
" Insert random labels
function! RandomLabel()
python3 << EOF
import random, string, vim
label = ''.join(random.choice(string.ascii_uppercase) for _ in range(6))
vim.command("let @z = '%s'" % label)
EOF
endfunction
autocmd FileType tex vmap <buffer> ,rl <Esc>:call RandomLabel()<CR>gv"zp
autocmd FileType tex imap <buffer> ,rl <Esc>:call RandomLabel()<CR>a<C-R>z
