(module yazdan.lsp.languages.nix
  {autoload {lspconfig lspconfig
             utils yazdan.lsp.utils}})

(defn setup []
  (lspconfig.rnix.setup {:on_attach utils.on_attach}))
