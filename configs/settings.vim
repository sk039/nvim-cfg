colorscheme gruvbox

" 设置命令行(statusline下面那行)高度
set cmdheight=1

set tabstop=8
set shiftwidth=8
" 空格代替tab
set noexpandtab
set softtabstop=8
"
"高亮搜索
"set hls
set cindent
"set autoindent
"set smartindent

" 设置匹配模式，显示匹配的括号
set showmatch
" 整词换行
set linebreak
" 光标从行首和行末时可以跳到另一行去
set whichwrap=b,s,<,>,[,]
" 禁用自动折行
"set nowrap

" 禁止生成临时文件
set nobackup
set noswapfile

set mouse=

let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

vnoremap <C-y> :'<,'>w !xclip -selection clipboard<Cr><Cr>

autocmd FileType json setlocal ts=2 sw=2 sts=2 expandtab
autocmd FileType markdown setlocal ts=3 sw=3 sts=3 expandtab

let g:vim_markdown_folding_disabled = 1

let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

" Enable neovim true colors support
set termguicolors

"https://jeffkreeftmeijer.com/vim-number/
set nu
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END
