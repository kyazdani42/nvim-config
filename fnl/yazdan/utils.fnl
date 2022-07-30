(module yazdan.utils)

(defn warn [msg]
  (vim.notify msg vim.log.levels.WARN))
