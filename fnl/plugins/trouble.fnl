(module plugins.trouble
  {autoload {trouble trouble}})

(def- icons {:error ""
             :warning "⚠"
             :hint ""
             :information ""
             :other ""})
             
(trouble.setup {:indent_lines false :signs icons})
