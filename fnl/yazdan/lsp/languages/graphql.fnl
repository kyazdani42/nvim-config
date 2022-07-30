(module yazdan.lsp.languages.graphql
  {autoload {lspconfig lspconfig
             utils yazdan.lsp.utils}})

(defn setup []
  (lspconfig.graphql.setup {:on_attach utils.on_attach
                            :filetypes [:graphql]}))
