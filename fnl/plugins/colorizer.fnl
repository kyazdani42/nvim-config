(module plugins.colorizer
  {autoload {colorizer colorizer}})

(vim.schedule (fn []
                (when (vim.api.nvim_get_option :termguicolors)
                  (colorizer.setup))))
