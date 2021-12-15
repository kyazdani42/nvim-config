(module init)

(require :options)
(require :autocmd)

(defn dump [...]
  (print 
    (unpack 
      (vim.tbl_map vim.inspect [...]))))

(set _G.dump dump)
