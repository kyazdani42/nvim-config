(module lsp.languages.nix
  {autoload {lspconfig lspconfig
             utils lsp.utils}})

(defn setup []
  (lspconfig.rnix.setup {:on_attach utils.on_attach}))
