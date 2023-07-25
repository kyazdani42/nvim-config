(module yazdan.lsp.handlers.definition
  {autoload {a aniseed.core}})

(defn- get-location-from [result]
  (if (vim.tbl_islist result) (a.first result) result))

(defn- jump-to [result]
  (vim.lsp.util.jump_to_location result :utf-8))

(defn handler [err result]
  (if (a.string? err)
    (nvim.err_writln err)
    (let [res (get-location-from result)]
      (if (a.nil? res)
        (utils.warn "No definition found")
        (jump-to res)))))
