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
         {:config (fn [] (require :yazdan.plugins.conjure))})

    (use "~/dev/nvim/plugins/blue-moon"
         {:config (fn [] (vim.cmd "colorscheme blue-moon"))})

    (use "~/dev/nvim/plugins/nvim-web-devicons"
         {:config (fn [] (require :yazdan.plugins.web-devicons))})

    (use "~/dev/nvim/plugins/nvim-tree.lua"
         {:config (fn [] (require :yazdan.plugins.nvim-tree))})

    (use "~/dev/nvim/plugins/nvim-treesitter"
         {:config (fn [] (require :yazdan.plugins.treesitter))})

    (use "~/dev/nvim/plugins/playground")

    (use :nvim-lua/plenary.nvim)
    (use :nvim-telescope/telescope.nvim
         {:config (fn [] (require :yazdan.plugins.telescope))})
    (use :nvim-telescope/telescope-ui-select.nvim)

    ; templating tag sync
    (use :windwp/nvim-ts-autotag
         {:config (fn [] (require :yazdan.plugins.autotag))})

    (use :lewis6991/gitsigns.nvim
         {:config (fn [] (require :yazdan.plugins.gitsigns))})

    ; comment plugin
    (use :b3nj5m1n/kommentary
         {:config (fn [] (require :yazdan.plugins.kommentary))})

    (use :norcalli/nvim-colorizer.lua
         {:config (fn [] (require :yazdan.plugins.colorizer))}) 

    ; refactoring patterns
    (use :ThePrimeagen/refactoring.nvim
         {:config (fn [] (require :yazdan.plugins.refactoring))})

    (use :neovim/nvim-lspconfig
         {:config (fn [] (require :yazdan.lsp))})

    (use :b0o/schemastore.nvim)

    ; native lsp improvements
    (use :tami5/lspsaga.nvim
         {:config (fn [] (require :yazdan.plugins.lsp-saga))})

    (use  "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
         {:config (fn [] ((. (require :lsp_lines) :setup)))})

    ; simplify highlighting
    (use :folke/twilight.nvim
         {:config (fn [] (require :yazdan.plugins.twilight))})

    ; lisps auto parens and format
    (use :eraserhd/parinfer-rust
         {:run "cargo build --release"})

    ; needed for nvim-cmp to function properly
    (use :hrsh7th/vim-vsnip)
    (use :hrsh7th/vim-vsnip-integ)

    (use :hrsh7th/nvim-cmp
         {:config (fn [] (require :yazdan.plugins.nvim-cmp))})

    ; icons for completion
    (use :onsails/lspkind-nvim)

    ; cmp completion plugins
    (use :hrsh7th/cmp-cmdline)
    (use :hrsh7th/cmp-buffer)
    (use :hrsh7th/cmp-path)
    (use :hrsh7th/cmp-nvim-lsp)
    (use :hrsh7th/cmp-nvim-lsp-document-symbol)
    (use :lukas-reineke/cmp-rg)

    (use :nvim-neotest/neotest
         {:requires 
            [:antoinemadec/FixCursorHold.nvim
             :nvim-neotest/neotest-plenary]
          :config (fn [] (require :yazdan.plugins.neotest))})

    (use :tpope/vim-surround)
    (use :editorconfig/editorconfig)

    (use :nvim-treesitter/nvim-treesitter-textobjects)
    (use :JoosepAlviste/nvim-ts-context-commentstring)

    ; git
    (use :tpope/vim-fugitive)
    (use :TimUntersberger/neogit)

    ; lua 5.1 reference documentation
    (use :milisims/nvim-luaref)
    ; lua neovim api completion
    (use :folke/lua-dev.nvim)

    ; statusline stuff
    (use :SmiteshP/nvim-gps)

    ; notifications
    (use :rcarriga/nvim-notify
         {:config (fn [] (require :yazdan.plugins.notify))})

    ; rust dependency management plugin
    (use :Saecki/crates.nvim)))

(packer.startup defn-plugins)
