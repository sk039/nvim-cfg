-- Setup language servers.
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

require("mason-lspconfig").setup()

local lspconfig = require('lspconfig')
local rt = require("rust-tools")

-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			--vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-n>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<TAB>'] = cmp.mapping.select_next_item(),
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
		{ name = 'cmdline' },
	})
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
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

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
--[[require('lspconfig')['<YOUR_LSP_SERVER>'].setup {]]
--[[capabilities = capabilities]]
--[[}]]

-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require("neodev").setup({
	-- add any options here, or leave empty to use the default settings
})

-- example to setup lua_ls and enable call snippets
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
		on_attach = function(client, bufnr)
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

--[[lspconfig.pyright.setup {}]]
--[[lspconfig.tsserver.setup {}]]

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
