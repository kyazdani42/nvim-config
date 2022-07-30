(module yazdan.plugins.colorizer
  {autoload {colorizer colorizer}})

(vim.schedule (lambda []
                (when (vim.api.nvim_get_option :termguicolors)
                  (colorizer.setup))))
