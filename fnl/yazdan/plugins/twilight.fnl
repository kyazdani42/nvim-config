(module yazdan.plugins.twilight
  {autoload {tw twilight}})

(def- config {:dimming {:alpha 0.3 :color ["#a6accd"]}})
(tw.setup config)
