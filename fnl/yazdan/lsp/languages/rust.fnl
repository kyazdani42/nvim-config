(module yazdan.lsp.languages.rust
  {autoload {lspconfig lspconfig
             utils yazdan.lsp.utils}})

(defn setup [cap]
  (lspconfig.rust_analyzer.setup
    {:on_attach utils.on_attach 
     :capabilities cap}))
