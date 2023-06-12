lua require("plugins")

" Enable neovim true colors support
set termguicolors

set clipboard+=unnamedplus

augroup packer_auto_compile
  autocmd!
  autocmd BufWritePost */nvim/lua/plugins.lua source <afile> | PackerCompile
augroup END

"https://jeffkreeftmeijer.com/vim-number/
set nu
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

exec 'source' stdpath('config') . '/' . 'configs/vim-crates.vim'
exec 'source' stdpath('config') . '/' . 'configs/vim-translator.vim'
exec 'source' stdpath('config') . '/' . 'configs/vista.vim'

