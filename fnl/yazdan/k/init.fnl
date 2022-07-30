(module yazdan.k
  {autoload {nvim aniseed.nvim}})

(defn- hidden? [buf]
  (= (. (. (vim.fn.getbufinfo buf) 1) :hidden) 1))

(defn delete-hidden-bufs []
  (each [_ buf (pairs (nvim.list_bufs))]
    (when (hidden? buf)
      (nvim.buf_delete buf { :force true}))))
