(module k
  {autoload {nvim aniseed.nvim
             k-react k.react}})

(fn hidden? [buf]
  (= (. (. (vim.fn.getbufinfo buf) 1) :hidden) 1))

(vim.cmd "command! -nargs=1 CreateComponent :lua K.react['create-component'](<f-args>)<CR>")

(defn delete-hidden-bufs []
  (each [_ buf (pairs (nvim.list_bufs))]
    (when (hidden? buf)
      (nvim.buf_delete buf { :force true }))))

(def react k-react)
