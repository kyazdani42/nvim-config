(module yazdan.lsp.languages.terraform
  {autoload {lspconfig lspconfig
             utils yazdan.lsp.utils}})

(defn setup []
  (lspconfig.terraformls.setup {:on_attach utils.on_attach}))
