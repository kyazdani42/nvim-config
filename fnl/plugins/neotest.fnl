(module plugins.neottest
  {autoload {neotest neotest}})

(neotest.setup
  {:adapters [(require :neotest-plenary)]
   :icons {:failed ""
           :passed ""
           :running "🗘"
           :skipped "ﰸ"
           :unknown "?"}})
