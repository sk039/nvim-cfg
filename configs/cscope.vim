" cscope设置
if has("cscope")
	if filereadable("cscope.out")
		cs add cscope.out
	else
		let cscope_file=findfile("cscope.out", ".;")
		let cscope_pre=matchstr(cscope_file, ".*/")
		if !empty(cscope_file) && filereadable(cscope_file)
			exe "cs add" cscope_file cscope_pre
		endif
	endif
	nmap <silent><c-\>c :cs f c <C-R>=expand("<cword>")  <CR><CR>
	nmap <silent><c-\>f :cs f f <C-R>=expand("<cfile>")  <CR><CR>
	nmap <silent><c-\>i :cs f i <C-R>=expand("<cfile>")  <CR><CR>
	nmap <silent><c-\>d :cs f d <C-R>=expand("<cword>")  <CR><CR>
	nmap <silent><c-\>s :cs f s <C-R>=expand("<cword>")  <CR><CR>
	nmap <silent><c-\>g :cs f g <C-R>=expand("<cword>")  <CR><CR>
endif


