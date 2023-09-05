(module yazdan.plugins
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
         {:config #(require :yazdan.plugins.conjure)})
    (use :eraserhd/parinfer-rust
         {:run "cargo build --release"})

    (use "~/dev/nvim/blue-moon"
         {:config #(vim.cmd "colorscheme blue-moon")})

    (use "nvim-tree/nvim-web-devicons"
         {:config #(require :yazdan.plugins.web-devicons)})

    (use "nvim-tree/nvim-tree.lua"
         {:config #(require :yazdan.plugins.nvim-tree)})

    (use "nvim-treesitter/nvim-treesitter"
         {:config #(require :yazdan.plugins.treesitter)})

    ; templating tag sync
    (use :windwp/nvim-ts-autotag
         {:config #(require :yazdan.plugins.autotag)})

    (use :JoosepAlviste/nvim-ts-context-commentstring)
    (use :b3nj5m1n/kommentary
         {:config #(require :yazdan.plugins.kommentary)})

    (use :nvim-lua/plenary.nvim)
    (use :nvim-telescope/telescope-ui-select.nvim)
    (use :nvim-telescope/telescope.nvim
         {:config #(require :yazdan.plugins.telescope)})

    (use :norcalli/nvim-colorizer.lua
         {:config #(require :yazdan.plugins.colorizer)})

    (use :neovim/nvim-lspconfig
         {:config #(require :yazdan.lsp)})

    (use :b0o/schemastore.nvim)

    ; simplify highlighting
    (use :folke/twilight.nvim
         {:config #(require :yazdan.plugins.twilight)})

    (use :hrsh7th/nvim-cmp
         {:config #(require :yazdan.plugins.nvim-cmp)})

    ; icons for completion
    (use :onsails/lspkind-nvim)
    ; cmp completion plugins
    (use :hrsh7th/cmp-buffer)
    (use :hrsh7th/cmp-path)
    (use :hrsh7th/cmp-nvim-lsp)
    (use :PaterJason/cmp-conjure)

    ; tpope & git
    (use :tpope/vim-surround)
    (use :tpope/vim-fugitive)
    (use :lewis6991/gitsigns.nvim
         {:config #(require :yazdan.plugins.gitsigns)})

    ; lua 5.1 reference documentation
    (use :milisims/nvim-luaref)
    ; lua neovim api completion
    (use :folke/neodev.nvim) ; setup with lua lsp

    ; notifications
    (use :rcarriga/nvim-notify
         {:config #(require :yazdan.plugins.notify)})))

(packer.startup defn-plugins)
