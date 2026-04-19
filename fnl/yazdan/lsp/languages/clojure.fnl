(module yazdan.lsp.languages.clojure
  {autoload {utils yazdan.lsp.utils}})

(defn setup []
  (vim.lsp.config :clojure_lsp {:on_attach utils.on_attach})
  (vim.lsp.enable :clojure_lsp))
