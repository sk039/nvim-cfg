-- load cscope maps
-- pass empty table to setup({}) for default options
require('cscope_maps').setup({
  disable_maps = true, -- true disables my keymaps, only :Cscope will be loaded
  cscope = {
    db_file = "./cscope.out", -- location of cscope db file
    exec = "cscope", -- "cscope" or "gtags-cscope"
    picker = "fzf-lua", -- "telescope", "fzf-lua" or "quickfix"
    db_build_cmd_args = { "-bqkv" }, -- args used for db build (:Cscope build)
  },
})

vim.api.nvim_set_keymap(
  "n",
  "<space>g",
  [[<cmd>lua require('cscope_maps').cscope_prompt('g', vim.fn.expand("<cword>"))<cr>]],
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<space>s",
  [[<cmd>lua require('cscope_maps').cscope_prompt('s', vim.fn.expand("<cword>"))<cr>]],
  { noremap = true, silent = true }
)
