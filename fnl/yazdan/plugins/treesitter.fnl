(module yazdan.plugins.treesitter
  {autoload {nvim aniseed.nvim}})

(vim.api.nvim_set_keymap :n "<leader>n" "van" {})
(vim.api.nvim_set_keymap :v "n" "an" {})
(vim.api.nvim_set_keymap :v "N" "in" {})

(vim.api.nvim_create_autocmd :Filetype {:callback (lambda [] (when (pcall vim.treesitter.start)
                                                                (set vim.wo.foldexpr "v:lua.vim.treesitter.foldexpr()")
                                                                (set vim.wo.foldmethod :expr)
                                                                (set vim.bo.indentexpr "v:lua.require'nvim-treesitter'.indentexpr()")))})
