(module lsp.languages.rust
  {autoload {lspconfig lspconfig
             utils lsp.utils}})

(defn setup []
  (lspconfig.rust_analyzer.setup {:on_attach utils.on_attach}))