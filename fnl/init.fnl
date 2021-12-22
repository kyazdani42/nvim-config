(module init
  {require {_ options
            k k
            _ autocmd
            _ keymap}})

(set _G.K k)

(defn dump [...]
  (print 
    (unpack 
      (vim.tbl_map vim.inspect [...]))))

(set _G.dump dump)
