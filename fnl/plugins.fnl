(module plugins
  {autoload {packer packer
             a aniseed.core}})

(defn- override-use [use]
  (fn [name opts]
    (use (a.assoc (or opts {}) 1 name))))

(defn defn-plugins [u]
  (let [use (override-use u)]
    (use :wbthomason/packer.nvim)
    (use :Olical/aniseed)
    (use :Olical/conjure
         {:config (fn [] (require :plugins.conjure))})

    (use "~/dev/nvim/plugins/blue-moon"
         {:config (fn [] (vim.cmd "colorscheme blue-moon"))})

    (use "~/dev/nvim/plugins/nvim-web-devicons"
         {:config (fn [] (require :plugins.web-devicons))})

    (use "~/dev/nvim/plugins/nvim-tree.lua"
         {:config (fn [] (require :plugins.nvim-tree))})

    (use "~/dev/nvim/plugins/nvim-treesitter"
         {:config (fn [] (require :plugins.treesitter))})

    (use "~/dev/nvim/plugins/playground")

    (use :nvim-lua/plenary.nvim)

    (use :cljoly/telescope-repo.nvim)
    (use :nvim-telescope/telescope.nvim
         {:config (fn [] (require :plugins.telescope))})

    (use :akinsho/nvim-bufferline.lua
         {:config (fn [] (require :plugins.bufferline))})

    (use :windwp/nvim-ts-autotag
         {:config (fn [] (require :plugins.autotag))})

    (use :lewis6991/gitsigns.nvim
         {:config (fn [] (require :plugins.gitsigns))})

    (use :b3nj5m1n/kommentary
         {:config (fn [] (require :plugins.kommentary))})

    (use :norcalli/nvim-colorizer.lua
         {:config (fn [] (require :plugins.colorizer))}) 

    (use :neovim/nvim-lspconfig
         {:config (fn [] (require :lsp))})

    (use :tami5/lspsaga.nvim
         {:config (fn [] (require :plugins.lsp-saga))})

    (use :folke/trouble.nvim
         {:config (fn [] (require :plugins.trouble))})

    (use :folke/twilight.nvim
         {:config (fn [] (require :plugins.twilight))})

    (use :eraserhd/parinfer-rust
         {:run "cargo build --release"})

    (use :pwntester/octo.nvim
         {:config (fn [] ((. (require :octo) :setup)))})

    ; needed for nvim-cmp to function properly
    (use :hrsh7th/vim-vsnip)
    (use :hrsh7th/vim-vsnip-integ)

    (use :hrsh7th/nvim-cmp
         {:config (fn [] (require :plugins.nvim-cmp))})

    (use :onsails/lspkind-nvim)
    (use :hrsh7th/cmp-cmdline)
    (use :hrsh7th/cmp-buffer)
    (use :hrsh7th/cmp-path)
    (use :hrsh7th/cmp-nvim-lua)
    (use :hrsh7th/cmp-nvim-lsp)
    (use :hrsh7th/cmp-nvim-lsp-document-symbol)
    (use :nvim-treesitter/nvim-treesitter-textobjects)
    (use :JoosepAlviste/nvim-ts-context-commentstring)
    (use :tpope/vim-surround)
    (use :tpope/vim-fugitive)
    (use :TimUntersberger/neogit)
    (use :editorconfig/editorconfig)
    (use :Saecki/crates.nvim)))

(packer.startup defn-plugins)
