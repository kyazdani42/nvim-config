(module plugins.notify
  {autoload {notify notify}})

(print :hello)
(notify.setup
  {:fps 60
   :level 1
   :timeout 1})
