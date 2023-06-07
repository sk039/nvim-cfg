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

  -- Programming
  -- C/C++/Rust
  use { 'neoclide/coc.nvim', branch = 'release' }
  use 'jackguo380/vim-lsp-cxx-highlight'
  -- Debugging
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
  -- Snippets
  use 'SirVer/ultisnips'
  use 'honza/vim-snippets'

  -- others
  use 'Darazaki/indent-o-matic'
  use 'jghauser/mkdir.nvim'
  use { 'echasnovski/mini.trailspace', branch = 'stable' }
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

  use 'anuvyklack/hydra.nvim'

  use {
    'karb94/neoscroll.nvim',
    config = function()
      require("neoscroll").setup {}
    end
  }

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
    'f-person/git-blame.nvim',
    config = function()
      vim.g.gitblame_enabled = 0
      vim.g.gitblame_message_template = '<author> • <sha> • <summary>'
      vim.g.gitblame_date_format = '%x'
    end
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

  use {
    'ekickx/clipboard-image.nvim',
    config = function()
      require'clipboard-image'.setup {
        -- Default configuration for all filetype
        default = {
          img_dir = "images",
          img_name = function() return os.date('%Y-%m-%d-%H-%M-%S') end, -- Example result: "2021-04-13-10-04-18"
          affix = "<\n  %s\n>" -- Multi lines affix
        },
        -- You can create configuration for ceartain filetype by creating another field (markdown, in this case)
        -- If you're uncertain what to name your field to, you can run `lua print(vim.bo.filetype)`
        -- Missing options from `markdown` field will be replaced by options from `default` field
        markdown = {
          img_dir = {"src", "assets", "img"}, -- Use table for nested dir (New feature form PR #20)
          img_dir_txt = "/assets/img",
          img_handler = function(img) -- New feature from PR #22
            local script = string.format('./image_compressor.sh "%s"', img.path)
            os.execute(script)
          end,
        }
      }
    end
  }

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
  --
  -- use { 
  --   'kylechui/nvim-surround',
  --   config = function() 
  --     require('nvim-surround').setup()
  --   end
  -- }

  use({
    'potamides/pantran.nvim',
    config = function() 
      require("pantran").setup{
        -- Default engine to use for translation. To list valid engine names run
        -- `:lua =vim.tbl_keys(require("pantran.engines"))`.
        default_engine = "google",
      }
    end 
  })

  -- themes
  use { 'morhetz/gruvbox', config = function() vim.cmd[[colorscheme gruvbox]] end }
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'xiyaowong/transparent.nvim'

end)
