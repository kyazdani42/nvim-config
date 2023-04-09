(module yazdan.plugins.notify
  {autoload {notify notify}})

(notify.setup
  {:fps 60
   :level 2
   :background_colour "#292d3e"
   :timeout 1})

(set vim.notify notify)
