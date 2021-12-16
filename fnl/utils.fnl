(module utils)

(defn warn [msg]
  (vim.cmd (string.format "echohl WarningMsg | echo '%s' | echohl Normal" msg)))
