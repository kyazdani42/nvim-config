(module yazdan.plugins.colorizer
  {autoload {nvim-highlight-colors nvim-highlight-colors}})

(vim.schedule (lambda []
                (when (vim.api.nvim_get_option :termguicolors)
                  (nvim-highlight-colors.setup {}))))
