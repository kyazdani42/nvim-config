(module lsp.languages.haskell
  {autoload {lspconfig lspconfig
             utils lsp.utils}})

(defn setup []
  (lspconfig.hls.setup {:on_attach utils.on_attach}))
