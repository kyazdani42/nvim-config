(module init)

(require :options)
(require :autocmd)
(set _G.K (require :k))

(defn dump [...]
  (print 
    (unpack 
      (vim.tbl_map vim.inspect [...]))))

(set _G.dump dump)
