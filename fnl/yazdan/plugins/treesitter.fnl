(module yazdan.plugins.treesitter
  {autoload {nvim aniseed.nvim
             nvim-gps nvim-gps
             configs nvim-treesitter.configs}})

(configs.setup
  {:highlight {:enable true}
   :incremental_selection {:enable true
                           :disable []
                           :keymaps {:init_selection "<leader>n"
                                     :node_incremental "n"
                                     :scope_incremental "<leader>m"
                                     :node_decremental "m"}}
   :indent {:enable true}
   :ensure_installed "all"
   :textobjects {:select {:enable true
                          :keymaps {"<leader>V" "@function.outer" ; replace with block.inner and block.outer when its supported in more languages
                                    "<leader>v" "@function.inner"}}

                 :swap {:enable true
                        :swap_next {"<leader>f" "@parameter.inner"} ; replace with block.inner when its supported in more languages
                        :swap_previous {"<leader>a" "@parameter.inner"}}}

   :context_commentstring {:enable true
                           :enable_autocmd false}})

(nvim-gps.setup)
