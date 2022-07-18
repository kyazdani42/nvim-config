(module plugins.notify
  {autoload {notify notify}})

(notify.setup
  {:fps 60
   :level 1
   :timeout 1})
