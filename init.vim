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

Plug 'nvim-tree/nvim-web-devicons'
" programming {
" python
Plug 'vim-python/python-syntax' " c/c++
Plug 'jackguo380/vim-lsp-cxx-highlight'
" rust
Plug 'mhinz/vim-crates'
Plug 'rust-lang/rust.vim'
" javascript
Plug 'pangloss/vim-javascript'
" tag view
Plug 'liuchengxu/vista.vim'
" text align
Plug 'junegunn/vim-easy-align'

Plug 'rhysd/vim-clang-format'
Plug 'preservim/nerdcommenter'
" }
" file browser
Plug 'nvim-tree/nvim-tree.lua'

" statusline
Plug 'nvim-lualine/lualine.nvim'
Plug 'arkav/lualine-lsp-progress'

" theme
Plug 'morhetz/gruvbox'
Plug 'xiyaowong/transparent.nvim'
" productive tools
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

" markdown
Plug 'preservim/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'ekickx/clipboard-image.nvim'
Plug 'ellisonleao/glow.nvim'
" vim translator
Plug 'voldikss/vim-translator'
Plug 'SpaceVim/VimCalc3'

Plug 'jeetsukumaran/vim-buffergator'
Plug 'chentoast/marks.nvim'

" ASCII drawing
Plug 'jbyuki/venn.nvim'
Plug 'riddlew/asciitree.nvim'

Plug 'nvim-lua/plenary.nvim'

" Programming
Plug 'williamboman/mason.nvim', { 'do': ':MasonUpdate' }
Plug 'williamboman/mason-lspconfig.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'

Plug 'folke/neodev.nvim'

" Auto Completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'HiPhish/nvim-ts-rainbow2'

" Debugging
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'

" luasnip
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" snippets collections
Plug 'honza/vim-snippets'

Plug 'jghauser/mkdir.nvim'

Plug 'dhananjaylatkar/cscope_maps.nvim'
Plug 'ibhagwan/fzf-lua'

Plug 'nmac427/guess-indent.nvim'
Plug 'tenxsoydev/tabs-vs-spaces.nvim'
Plug 'ntpeters/vim-better-whitespace'
"Plug 'johnfrankmorgan/whitespace.nvim'

Plug 'FotiadisM/tabset.nvim'

Plug 'kevinhwang91/nvim-bqf'

Plug 'liuchengxu/vim-which-key'

Plug 'nvim-telescope/telescope.nvim'
Plug 'nvimdev/dashboard-nvim'
call plug#end()

exec 'source' stdpath('config') . '/' . 'configs/settings.vim'
exec 'source' stdpath('config') . '/' . 'configs/nerdcommenter.vim'
exec 'source' stdpath('config') . '/' . 'configs/ctrlp.vim'
exec 'source' stdpath('config') . '/' . 'configs/vista.vim'
exec 'source' stdpath('config') . '/' . 'configs/vimtex.vim'
exec 'source' stdpath('config') . '/' . 'configs/crates.vim'
exec 'source' stdpath('config') . '/' . 'configs/undotree.vim'
exec 'source' stdpath('config') . '/' . 'configs/gitgutter.vim'
exec 'source' stdpath('config') . '/' . 'configs/mdimgpsate.vim'
exec 'source' stdpath('config') . '/' . 'configs/translator.vim'
exec 'source' stdpath('config') . '/' . 'configs/floaterm.vim'
exec 'source' stdpath('config') . '/' . 'configs/vim-better-whitespace.vim'
exec 'source' stdpath('config') . '/' . 'configs/which-key.vim'

exec 'luafile' stdpath('config') . '/' . 'configs/transparent.lua'
exec 'luafile' stdpath('config') . '/' . 'configs/lualine.lua'
exec 'luafile' stdpath('config') . '/' . 'configs/nvim-tree.lua'
exec 'luafile' stdpath('config') . '/' . 'configs/marks.lua'
exec 'luafile' stdpath('config') . '/' . 'configs/nvim-treesitter.lua'
exec 'luafile' stdpath('config') . '/' . 'configs/venn.lua'
exec 'luafile' stdpath('config') . '/' . 'configs/nvim-dap.lua'
exec 'luafile' stdpath('config') . '/' . 'configs/lspconfig.lua'
exec 'luafile' stdpath('config') . '/' . 'configs/glow.lua'
exec 'luafile' stdpath('config') . '/' . 'configs/guess-indent.lua'
exec 'luafile' stdpath('config') . '/' . 'configs/clipboard-image.lua'
exec 'luafile' stdpath('config') . '/' . 'configs/tabs-vs-spaces.lua'
exec 'luafile' stdpath('config') . '/' . 'configs/nvim-bqf.lua'
exec 'luafile' stdpath('config') . '/' . 'configs/tabset.lua'
exec 'luafile' stdpath('config') . '/' . 'configs/nvim-ts-rainbow2.lua'
exec 'luafile' stdpath('config') . '/' . 'configs/dashboard-nvim.lua'
exec 'luafile' stdpath('config') . '/' . 'configs/cscope_maps.lua'
