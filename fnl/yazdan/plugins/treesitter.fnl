(module yazdan.plugins.treesitter
  {autoload {nvim aniseed.nvim
             configs nvim-treesitter.configs
             parsers nvim-treesitter.parsers}})

(configs.setup
  {:highlight {:enable true}
   :incremental_selection {:enable true
                           :disable []
                           :keymaps {:init_selection "<leader>n"
                                     :node_incremental "n"
                                     :scope_incremental "<leader>m"
                                     :node_decremental "m"}}
   :indent {:enable true}
   :ensure_installed {}
   :auto_install true
   :textobjects {:select {:enable true
                          :keymaps {"<leader>V" "@function.outer" ; replace with block.inner and block.outer when its supported in more languages
                                    "<leader>v" "@function.inner"}}

                 :swap {:enable true
                        :swap_next {"<leader>f" "@parameter.inner"} ; replace with block.inner when its supported in more languages
                        :swap_previous {"<leader>a" "@parameter.inner"}}}

   :context_commentstring {:enable true
                           :enable_autocmd false}})
