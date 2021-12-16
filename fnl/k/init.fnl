(module k
  {autoload {nvim aniseed.nvim}})

(fn hidden? [buf]
  (= (. (. (vim.fn.getbufinfo buf) 1) :hidden) 1))

(defn delete_hidden_bufs []
  (each [_ buf (pairs (nvim.list_bufs))]
    (when (hidden? buf)
      (nvim.buf_delete buf { :force true }))))
