vim.g.package_home = vim.fn.stdpath("data") .. "/site/pack/packer"
local packer_install_dir = vim.g.package_home .. "/start/packer.nvim"

local plug_url_format = "https://github.com/%s"

local packer_repo = string.format(plug_url_format, "wbthomason/packer.nvim")
local install_cmd = string.format("10split |term git clone --depth=1 %s %s", packer_repo, packer_install_dir)

-- Auto-install packer in case it hasn't been installed.
if vim.fn.glob(packer_install_dir) == "" then
	vim.api.nvim_echo({ { "Installing packer.nvim", "Type" } }, true, {}) vim.cmd(install_cmd)
end

-- Load packer.nvim
vim.cmd("packadd packer.nvim")

-- plugins
-- https://github.com/wbthomason/packer.nvim/blob/master/README.md#quickstart
return require('packer').startup(function(use)

	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use 'nvim-tree/nvim-web-devicons'
	use 'nvim-lua/plenary.nvim'

	-- Themes
	use { 'morhetz/gruvbox', config = function() vim.cmd[[colorscheme gruvbox]] end }
	use 'xiyaowong/transparent.nvim'
	-- Status line
	use {
		'nvim-lualine/lualine.nvim',
		config = function()
			require('lualine').setup {
				options = {
					icons_enabled = true,
					theme = 'auto',
					component_separators = { left = '', right = ''},
					section_separators = { left = '', right = ''},
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = false,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					}
				},
				sections = {
					lualine_a = {'mode'},
					lualine_b = {'branch', 'diff', 'diagnostics'},
					lualine_c = {'filename', 'lsp_progress'},
					lualine_x = {'encoding', 'fileformat', 'filetype'},
					lualine_y = {'progress'},
					lualine_z = {'location'}
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {'filename'},
					lualine_x = {'location'},
					lualine_y = {},
					lualine_z = {}
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = {}
			}
		end
	}
	use 'arkav/lualine-lsp-progress'

	-- Buffer line
	use {
		'akinsho/bufferline.nvim',
		config = function ()
			require("bufferline").setup{}
		end
	}

	-- Startup Page
	use 'nvim-telescope/telescope.nvim'
	use {
		'nvimdev/dashboard-nvim',
		config = function ()
			require('dashboard').setup {}
		end
	}

	-- Programming
	-- Rust
	use 'mhinz/vim-crates'
	use { 'rust-lang/rust.vim', ft = { "rust" } }
	use { 'cespare/vim-toml', ft = { "toml" } }

	-- Python
	use { 'vim-python/python-syntax', ft = { "python" } }

	-- C/C++
	use { 'jackguo380/vim-lsp-cxx-highlight', ft = { "c", "cpp" } }
	use {
		'dhananjaylatkar/cscope_maps.nvim',
		ft = { "c", "cpp", "asm" },
		config = function ()
			-- load cscope maps
			-- pass empty table to setup({}) for default options
			require('cscope_maps').setup({
				disable_maps = true, -- true disables my keymaps, only :Cscope will be loaded
				cscope = {
					db_file = "./cscope.out", -- location of cscope db file
					exec = "cscope", -- "cscope" or "gtags-cscope"
					picker = "telescope", -- "telescope", "fzf-lua" or "quickfix"
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
		end
	}

	-- LSP
	use {
		'williamboman/mason.nvim',
		config = function()
			require("mason").setup({
				PATH = "prepend", -- "skip" seems to cause the spawning error
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗"
					}
				}
			})
		end
	}
	use {
		'williamboman/mason-lspconfig.nvim',
		requires = { 'williamboman/mason.nvim' },
		after = { 'mason.nvim' },
		config = function()
			require("mason-lspconfig").setup {
				ensure_installed = { "lua_ls", "rust_analyzer" },
				automatic_installation = true,
			}
		end
	}
	use 'folke/neodev.nvim'
	use {
		'neovim/nvim-lspconfig',
		config = function ()
			local lspconfig = require('lspconfig')
			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			require("neodev").setup({
				-- add any options here, or leave empty to use the default settings
			})

			lspconfig.texlab.setup({
				capabilities = capabilities,
				settings = {
					texlab = {
						build = {
							args = { "-xelatex", '-latexoption="--shell-escape"', "%f" },
							executable = "latexmk",
							forwardSearchAfter = false,
							onSave = false
						},
					}
				}
			})

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace"
						}
					}
				}
			})

			lspconfig.ccls.setup {
				capabilities = capabilities,
				filetypes = { "c", "cpp", "objc", "objcpp", "S", "s" },
				init_options = {
					highlight = {
						lsRanges = true;
					};
					index = {
						threads = 2;
					};
					clang = {
						excludeArgs = {
							"-fno-var-tracking-assignments",
							"-mstack-protector-guard=sysreg",
							"-mstack-protector-guard-reg=sp_el0",
							"-mstack-protector-guard-offset=1384",
							"-mabi=lp64",
							"-fconserve-stack",
							"-falign-jumps=1",
							"-falign-loops=1",
							"-fconserve-stack",
							"-fmerge-constants",
							"-fno-code-hoisting",
							"-fno-schedule-insns",
							"-fno-sched-pressure",
							"-fno-var-tracking-assignments",
							"-fsched-pressure",
							"-mhard-float",
							"-mindirect-branch-register",
							"-mindirect-branch=thunk-inline",
							"-mpreferred-stack-boundary=2",
							"-mpreferred-stack-boundary=3",
							"-mpreferred-stack-boundary=4",
							"-mrecord-mcount",
							"-mindirect-branch=thunk-extern",
							"-mno-fp-ret-in-387",
							"-mskip-rax-setup",
							"--param=allow-store-data-races=0",
							"-Wa,arch/x86/kernel/macros.s",
							"-Wa,-"
						} ;
						extraArgs = {
							"--gcc-toolchain=/usr"
						};
					};
				}
			}

			-- Global mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
			vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
			vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
			vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('UserLspConfig', {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
					vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
					vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
					vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
					vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
					vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set('n', '<space>wl', function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
					vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
					vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
					vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
					vim.keymap.set('n', '<space>f', function()
						vim.lsp.buf.format { async = true }
					end, opts)
				end,
			})

		end
	}
	use {
		'simrat39/rust-tools.nvim',
		config = function ()
			local rt = require("rust-tools")
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			rt.setup({
				server = {
					settings = {
						['rust-analyzer'] = {
							diagnostics = {
								enable = false;
							},
							procMacro = {
								enable = true;
							},
							inlayHints = {
								chainingHints = {
									enable = true;
								}
							},
							completion = {
								autoimport = {
									enable = true;
								}
							},
						}
					},
					capabilities = capabilities,
					on_attach = function(_, bufnr)
						-- Hover actions
						vim.keymap.set("n", "<Leader>r", rt.hover_actions.hover_actions, { buffer = bufnr })
						-- Code action groups
						vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })

						vim.api.nvim_create_autocmd("CursorHold", {
							buffer = bufnr,
							callback = function()
								local opts = {
									focusable = false,
									close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
									border = 'rounded',
									source = 'always',
									prefix = ' ',
									scope = 'cursor',
								}
								vim.diagnostic.open_float(nil, opts)
							end
						})
					end,
				},
				dap = {
					adapter = {
						type = "server",
						port = "${port}",
						executable = {
							command = "/opt/workdir/extension/adapter/codelldb",
							args = {"--port", "${port}"},
						},
						name = "rt_lldb",
					},
				},
			})
		end
	}

	use {
		'kevinhwang91/nvim-bqf',
		config = function ()
			-- https://github.com/neovim/neovim/issues/5722 "Disable QuickFixLine highlighting #5722"
			vim.cmd([[
			hi BqfPreviewBorder guifg=#3e8e2d ctermfg=71
			hi BqfPreviewTitle guifg=#3e8e2d ctermfg=71
			hi BqfPreviewThumb guibg=#3e8e2d ctermbg=71
			hi link BqfPreviewRange Search
			hi QuickFixLine cterm=bold ctermfg=none ctermbg=none
			]])

			require('bqf').setup({
				auto_enable = true,
				auto_resize_height = true, -- highly recommended enable
				preview = {
					win_height = 12,
					win_vheight = 12,
					delay_syntax = 80,
					border = {'┏', '━', '┓', '┃', '┛', '━', '┗', '┃'},
					show_title = false,
					should_preview_cb = function(bufnr, qwinid)
						local ret = true
						local bufname = vim.api.nvim_buf_get_name(bufnr)
						local fsize = vim.fn.getfsize(bufname)
						if fsize > 100 * 1024 then
							-- skip file size greater than 100k
							ret = false
						elseif bufname:match('^fugitive://') then
							-- skip fugitive buffer
							ret = false
						end
						return ret
					end
				},
				-- make `drop` and `tab drop` to become preferred
				func_map = {
					drop = 'o',
					openc = 'O',
					split = '<C-s>',
					tabdrop = '<C-t>',
					-- set to empty string to disable
					tabc = '',
					ptogglemode = 'z,',
				},
				filter = {
					fzf = {
						action_for = {['ctrl-s'] = 'split', ['ctrl-t'] = 'tab drop'},
						extra_opts = {'--bind', 'ctrl-o:toggle-all', '--prompt', '> '}
					}
				}
			})
			vim.g.quickr_preview_on_cursor = 1
		end
	}

	-- Snippets
	use {
		'L3MON4D3/LuaSnip',
		requires = {
			'honza/vim-snippets',
			'rafamadriz/friendly-snippets',
		},
		config = function()
			-- https://github.com/L3MON4D3/LuaSnip/blob/master/README.md#add-snippets
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_snipmate").lazy_load()
			require("luasnip").filetype_extend("all", { "_" })
		end
	}
	use 'saadparwaiz1/cmp_luasnip'

	-- AutoCompletion
	use {
		'hrsh7th/nvim-cmp',
		requires = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'petertriho/cmp-git',
		},
		config = function ()
			local cmp = require'cmp'
			local luasnip = require'luasnip'
			cmp.setup({
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						--vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
						luasnip.lsp_expand(args.body) -- For `luasnip` users.
						-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
						-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
					end,
				},
				window = {
					-- completion = cmp.config.window.bordered(),
					-- documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					-- https://sbulav.github.io/vim/neovim-setting-up-luasnip/
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-n>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<C-j>'] = cmp.mapping.select_next_item(),
					['<C-k>'] = cmp.mapping.select_prev_item(),
					['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					--{ name = 'vsnip' }, -- For vsnip users.
					{ name = 'luasnip' }, -- For luasnip users.
					-- { name = 'ultisnips' }, -- For ultisnips users.
					-- { name = 'snippy' }, -- For snippy users.
				}, {
					{ name = 'buffer' },
					{ name = 'path' },
				})
			})

			-- Set configuration for specific filetype.
			cmp.setup.filetype('gitcommit', {
				sources = cmp.config.sources({
					{ name = 'git' },
				}, {
					{ name = 'buffer' },
				})
			})

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ '/', '?' }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = 'buffer' }
				}
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'path' }
				}, {
					{ name = 'cmdline' }
				})
			})
		end
	}

	use 'nvim-treesitter/nvim-treesitter'
	use {
		'HiPhish/nvim-ts-rainbow2',
		after = {'nvim-treesitter'},
		config = function()
			require'nvim-treesitter.configs'.setup {
				-- A list of parser names, or "all" (the five listed parsers should always be installed)
				ensure_installed = { "c", "rust", "lua", "vim", "vimdoc", "query" },

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = true,

				-- List of parsers to ignore installing (for "all")
				ignore_install = { "javascript" },

				---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
				-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

				highlight = {
					enable = true,

					-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
					-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
					-- the name of the parser)
					-- list of language that will be disabled
					-- disable = { "c", "rust" },
					-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
					disable = function(lang, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,

					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = false,
				},
				rainbow = {
					enable = true,
					-- list of languages you want to disable the plugin for
					disable = { 'jsx' },
					-- Which query to use for finding delimiters
					query = 'rainbow-parens',
					-- Highlight the entire buffer all at once
					strategy = require('ts-rainbow').strategy.global,
				}
			}
		end
	}

	-- Tag browser
	use 'liuchengxu/vista.vim'

	-- Debugging
	use 'mfussenegger/nvim-dap'
	use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
	use 'theHamsta/nvim-dap-virtual-text'

	-- Git
	use {
		'f-person/git-blame.nvim',
		config = function()
			vim.g.gitblame_enabled = 0
			vim.g.gitblame_message_template = '<author> • <sha> • <summary>'
			vim.g.gitblame_date_format = '%x'
		end
	}
	use 'airblade/vim-gitgutter'
	use 'tpope/vim-fugitive'

	-- Markdown
	use {
		'preservim/vim-markdown',
		ft = { "markdown" },
		config = function ()
			vim.g.vim_markdown_folding_disabled = 1
		end
	}
	use 'mzlogin/vim-markdown-toc'
	use({
		"iamcco/markdown-preview.nvim",
		ft = { "markdown" },
		run = function() vim.fn["mkdp#util#install"]() end,
	})
	use {
		'ekickx/clipboard-image.nvim',
		config = function()
			require'clipboard-image'.setup {}
		end
	}
	use { "ellisonleao/glow.nvim", ft = { "markdown" }, config = function() require("glow").setup() end }

	-- Latex
	use {
		'lervag/vimtex',
		ft = { 'tex' },
		config = function ()
			-- use treesitter to syntax highlighting
			vim.g.vimtex_syntax_enabled = 0
		end
	}
	use {
		"iurimateus/luasnip-latex-snippets.nvim",
		config = function()
			require'luasnip-latex-snippets'.setup({ use_treesitter = true })
		end,
		-- treesitter is required for markdown
		ft = { "tex", "markdown" },
	}
	use { 'xuhdev/vim-latex-live-preview', ft = { 'tex' } }

	-- Formating
	use {
		'nmac427/guess-indent.nvim',
		config = function ()
			require('guess-indent').setup {}
		end
	}
	use {
		'tenxsoydev/tabs-vs-spaces.nvim',
		config = function ()
			require("tabs-vs-spaces").setup {
				-- Preferred indentation. Possible values: "auto"|"tabs"|"spaces".
				-- "auto" detects the dominant indentation style in a buffer and highlights deviations.
				indentation = "auto",
				-- Use a string like "DiagnosticUnderlineError" to link the `TabsVsSpace` highlight to another highlight.
				-- Or a table valid for `nvim_set_hl` - e.g. { fg = "MediumSlateBlue", undercurl = true }.
				highlight = { fg = "MediumSlateBlue", undercurl = true },
				-- Priority of highight matches.
				priority = 20,
				ignore = {
					filetypes = {
						"dashboard",
					},
					-- Works for normal buffers by default.
					buftypes = {
						"acwrite",
						"help",
						"nofile",
						"nowrite",
						"quickfix",
						"terminal",
						"prompt",
					},
				},
				standartize_on_save = false,
				-- Enable or disable user commands see Readme.md/#Commands for more info.
				user_commands = true,
			}

		end
	}
	use {
		'ntpeters/vim-better-whitespace',
		config = function ()
			vim.g.better_whitespace_enabled = 1
			vim.g.strip_whitespace_on_save = 1
			vim.g.better_whitespace_filetypes_blacklist={'dashboard', 'diff',
			'git', 'gitcommit', 'unite', 'qf', 'help', 'markdown', 'fugitive'}
		end
	}
	-- use 'johnfrankmorgan/whitespace.nvim'
	use {
		'FotiadisM/tabset.nvim',
		config = function ()
			require("tabset").setup({
				defaults = {
					tabwidth = 4,
					expandtab = true
				},
				languages = {
					go = {
						tabwidth = 4,
						expandtab = false
					},
					c = {
						tabwidth = 8,
						expandtab = false
					},
					{
						filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "json", "yaml" },
						config = {
							tabwidth = 2
						}
					}
				}
			})
		end
	}

	use 'jghauser/mkdir.nvim'

	-- Utils
	use 'sbdchd/neoformat'
	use 'mbbill/undotree'
	use {
		'numToStr/FTerm.nvim',
		config = function ()
			require'FTerm'.setup({
				border = 'double',
				dimensions  = {
					height = 0.9,
					width = 0.9,
				},
			})
			vim.api.nvim_create_user_command('FTermOpen', require('FTerm').open, { bang = true })
			vim.api.nvim_create_user_command('FTermClose', require('FTerm').close, { bang = true })
			vim.api.nvim_create_user_command('FTermExit', require('FTerm').exit, { bang = true })
			vim.api.nvim_create_user_command('FTermToggle', require('FTerm').toggle, { bang = true })
			vim.keymap.set('n', '<A-t>', '<CMD>FTermToggle<CR>')
			vim.cmd[[tnoremap <A-t> <CMD>FTermToggle<CR>]]
			-- `Ctrl-\ Ctrl-N` to enter normal mode from the terminal.
			-- vim.cmd[[tnoremap <Esc> <C-\><C-n>]]
		end
	}
	use 'junegunn/fzf'
	use({
		'liuchengxu/vim-clap',
		config = function ()
			-- clap#job#daemon#start error workaround
			-- https://github.com/liuchengxu/vim-clap/blob/master/plugin/clap.vim#L14
			vim.g.clap_start_server_on_startup = 0
		end,
		run = function()
			vim.fn["clap#installer#force_download"]()
		end,
	})

	use 'machakann/vim-highlightedyank'
	use {
		'karb94/neoscroll.nvim',
		config = function()
			require("neoscroll").setup {}
		end
	}
	use 'voldikss/vim-translator'
	use 'SpaceVim/VimCalc3'
	use {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	}
	use {
		"windwp/nvim-autopairs",
		config = function() require("nvim-autopairs").setup {} end
	}
	use {
		'phaazon/hop.nvim',
		branch = 'v2', -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
		end
	}
	--[[   use {
		'https://git.sr.ht/~reggie/licenses.nvim',
		config = function()
			require('licenses').setup({
				copyright_holder = 'Ke Sun',
				email = 'sunke@kylinos.cn',
			})
		end
	} ]]
	use 'anuvyklack/hydra.nvim'
	use 'jeetsukumaran/vim-buffergator'
	use {
		'chentoast/marks.nvim',
		config = function()
			require'marks'.setup {
				-- whether to map keybinds or not. default true
				default_mappings = true,
				-- which builtin marks to show. default {}
				builtin_marks = { ".", "<", ">", "^" },
				-- whether movements cycle back to the beginning/end of buffer. default true
				cyclic = true,
				-- whether the shada file is updated after modifying uppercase marks. default false
				force_write_shada = false,
				-- how often (in ms) to redraw signs/recompute mark positions.
				-- higher values will have better performance but may cause visual lag,
				-- while lower values may cause performance penalties. default 150.
				refresh_interval = 250,
				-- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
				-- marks, and bookmarks.
				-- can be either a table with all/none of the keys, or a single number, in which case
				-- the priority applies to all marks.
				-- default 10.
				sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
				-- disables mark tracking for specific filetypes. default {}
				excluded_filetypes = {},
				-- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
				-- sign/virttext. Bookmarks can be used to group together positions and quickly move
				-- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
				-- default virt_text is "".
				bookmark_0 = {
					sign = "⚑",
					virt_text = "hello world",
					-- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
					-- defaults to false.
					annotate = false,
				},
				mappings = {}
			}
		end
	}
	use {
		'kylechui/nvim-surround',
		config = function()
			require('nvim-surround').setup()
		end
	}
	use {
		'nvim-tree/nvim-tree.lua',
		config = function ()
			-- disable netrw at the very start of your init.lua
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
			require("nvim-tree").setup({
				sort_by = "case_sensitive",
				view = {
					width = 30,
				},
				renderer = {
					group_empty = true,
				},
				filters = {
					dotfiles = true,
				},
			})

		end
	}

	-- ASCII drawing
	use {
		'jbyuki/venn.nvim',
		config = function()
			function _G.Toggle_venn()
				local venn_enabled = vim.inspect(vim.b.venn_enabled)
				if venn_enabled == "nil" then
					vim.b.venn_enabled = true
					vim.cmd[[setlocal ve=all]]
					-- draw a line on HJKL keystokes
					vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", {noremap = true})
					vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", {noremap = true})
					vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", {noremap = true})
					vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", {noremap = true})
					-- draw a box by pressing "f" with visual selection
					vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", {noremap = true})
				else
					vim.cmd[[setlocal ve=]]
					vim.cmd[[mapclear <buffer>]]
					vim.b.venn_enabled = nil
				end
			end
			-- toggle keymappings for venn using <leader>v
			vim.api.nvim_set_keymap('n', '<leader>v', ":lua Toggle_venn()<CR>", { noremap = true})
		end
	}
	use 'riddlew/asciitree.nvim'
	use {
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
		end
	}

end)
