(module lsp.languages.go
  {autoload {lspconfig lspconfig
             utils lsp.utils}})

(defn setup []
  (lspconfig.gopls.setup {:on_attach utils.on_attach}))
