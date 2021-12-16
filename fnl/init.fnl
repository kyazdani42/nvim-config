(module init
  {require {k k
            _ options
            _ autocmd}})

(set _G.K k)

(defn dump [...]
  (print 
    (unpack 
      (vim.tbl_map vim.inspect [...]))))

(set _G.dump dump)
