(module yazdan.dump)

(defn dump [...]
  (print
    (unpack
      (vim.tbl_map vim.inspect [...]))))

(set _G.dump dump)
