(module init
  {require {_ options
            k k
            _ plugins
            _ autocmd
            _ mappings
            _ statusline}})

(set _G.K k)

(defn dump [...]
  (print 
    (unpack 
      (vim.tbl_map vim.inspect [...]))))

(set _G.dump dump)
