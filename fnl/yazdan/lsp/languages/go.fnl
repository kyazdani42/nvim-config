(module yazdan.lsp.languages.go
  {autoload {utils yazdan.lsp.utils}})

(defn setup []
  (vim.lsp.config :gopls {:on_attach utils.on_attach})
  (vim.lsp.enable :gopls))
