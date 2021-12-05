vim.cmd "packadd! packer.nvim"

require('packer').startup(function()
  use {'wbthomason/packer.nvim', opt = true}

  use {
    '~/dev/plugins/blue-moon',
    config = function() vim.cmd "colorscheme blue-moon" end
  }

  use {
    '~/dev/plugins/nvim-web-devicons',
    config = function()
      require "plugins.web-devicons"
    end
  }

  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {}
    end
  }

  use {
    '~/dev/plugins/nvim-tree.lua',
    config = function() require'plugins.nvim-tree' end
  }

  use {
    '~/dev/plugins/nvim-treesitter',
    config = function() require'plugins.treesitter'.setup() end
  }

  use '~/dev/plugins/playground'

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function() require'plugins.telescope' end,
  }

  use {
    'akinsho/nvim-bufferline.lua',
    config = function() require'plugins.bufferline' end
  }

  use {
    'rafcamlet/nvim-luapad',
    config = function() vim.g.luapad_preview = 0 end,
    ft = {'lua'}
  }

  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  use {
    'windwp/nvim-ts-autotag',
    config = function() require'nvim-ts-autotag'.setup() end
  }

  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function() require'plugins.gitsigns' end
  }

  use 'tpope/vim-surround'
  use 'tpope/vim-fugitive'

  use {
    'b3nj5m1n/kommentary',
    setup = function()
      vim.g.kommentary_create_default_mappings = false
    end,
    config = function()
      require('kommentary.config').configure_language("default", {
        prefer_single_line_comments = true,
      })
      vim.api.nvim_set_keymap("n", "++", "<Plug>kommentary_line_default", { silent = true })
      vim.api.nvim_set_keymap("v", "++", "<Plug>kommentary_visual_default", { silent = true })
      vim.cmd [[
        augroup KommentaryCmd
          au CursorHold * lua require'ts_context_commentstring.internal'.update_commentstring()
        augroup END
      ]]
    end
  }

  use {
    'editorconfig/editorconfig',
    setup = function()
      vim.g.EditorConfig_exclude_patterns = {
        'fugitive://.*',
        'scp://.*'
      }
    end
  }

  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      if vim.api.nvim_get_option('termguicolors') then
        require'colorizer'.setup()
      end
    end
  }

  -- temporary just for nvim-cmp to function properly
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'

  use {
    'hrsh7th/nvim-cmp',
    config = function() require 'plugins.completion' end
  }
  use 'onsails/lspkind-nvim'
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-nvim-lua"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lsp-document-symbol"

  use {
    'neovim/nvim-lspconfig',
    config = function() require'lsp'.setup() end,
  }

  use {
    'tami5/lspsaga.nvim',
    config = function() require'lsp.saga'.setup() end
  }

  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }

  use {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup {
        indent_lines = false,
        signs = {
          error = "",
          warning = "⚠",
          hint = "",
          information = "",
          other = ""
        }
      }
    end
  }

  use {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {
        dimming = {
          alpha = 0.3,
          color = { "#a6accd" },
        }
      }
    end
  }

  use {
    'pwntester/octo.nvim',
    config = function()
      require'octo'.setup()
    end,
  }
end)
