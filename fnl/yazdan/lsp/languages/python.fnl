(module yazdan.lsp.languages.python
  {autoload {lspconfig lspconfig
             utils yazdan.lsp.utils}})

(defn setup []
  (lspconfig.pyright.setup {:on_attach utils.on_attach
                            :single_file_support true}))
