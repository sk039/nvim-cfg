" Manual install vim-plug
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" https://exvim.github.io/docs/plugins/

" Auto install vim-plug
" https://github.com/junegunn/vim-plug/wiki/tips
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-plug'
" programming {
" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" python
Plug 'vim-python/python-syntax' " c/c++
Plug 'jackguo380/vim-lsp-cxx-highlight'
" rust
Plug 'mhinz/vim-crates'
Plug 'rust-lang/rust.vim'
" javascript
Plug 'pangloss/vim-javascript'
" tag view
"Plug 'majutsushi/tagbar'
Plug 'liuchengxu/vista.vim'
" text align
Plug 'godlygeek/tabular'
" snippets
Plug 'SirVer/ultisnips'
" snippets collections
Plug 'honza/vim-snippets'
Plug 'rhysd/vim-clang-format'
Plug 'preservim/nerdcommenter'
" }
" file browser
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
" theme
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'tribela/vim-transparent'
" productive tools
Plug 'ntpeters/vim-better-whitespace'
Plug 'mbbill/undotree'
Plug 'justinmk/vim-sneak'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf'
Plug 'voldikss/vim-floaterm'
Plug 'tpope/vim-surround'
Plug 'Chiel92/vim-autoformat'
Plug 'easymotion/vim-easymotion'
Plug 'liuchengxu/vim-clap'
" latex
Plug 'lervag/vimtex', {'for': ['tex']}
"Plug 'latex-lsp/texlab'
Plug 'xuhdev/vim-latex-live-preview', {'for': ['tex']}
" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'liuchengxu/vim-which-key'
" markdown
Plug 'preservim/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'ferrine/md-img-paste.vim', {'for': ['markdown']}
" vim translator
Plug 'voldikss/vim-translator'
Plug 'SpaceVim/VimCalc3'

Plug 'luochen1990/rainbow'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'chentoast/marks.nvim'

" ASCII drawing
Plug 'jbyuki/venn.nvim'
Plug 'riddlew/asciitree.nvim'
call plug#end()

source ~/.config/nvim/configs/settings.vim
source ~/.config/nvim/configs/cscope.vim
source ~/.config/nvim/configs/nerdtree.vim
source ~/.config/nvim/configs/nerdcommenter.vim
source ~/.config/nvim/configs/ctrlp.vim
source ~/.config/nvim/configs/marks.lua
source ~/.config/nvim/configs/venn.lua
source ~/.config/nvim/configs/vista.vim
source ~/.config/nvim/configs/coc.vim
source ~/.config/nvim/configs/airline.vim
source ~/.config/nvim/configs/vimtex.vim
source ~/.config/nvim/configs/crates.vim
source ~/.config/nvim/configs/undotree.vim
source ~/.config/nvim/configs/gitgutter.vim
source ~/.config/nvim/configs/mdimgpsate.vim
source ~/.config/nvim/configs/translator.vim
source ~/.config/nvim/configs/floaterm.vim
source ~/.config/nvim/configs/which-key.vim

