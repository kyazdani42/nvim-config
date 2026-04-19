(module yazdan.lsp.languages.rust
  {autoload {utils yazdan.lsp.utils}})

(defn setup [cap]
  (vim.lsp.config :rust_analyzer
    {:on_attach utils.on_attach
     :capabilities cap})
  (vim.lsp.enable :rust_analyzer))
