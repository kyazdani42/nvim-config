(module yazdan.lsp.languages.yaml
  {autoload {lspconfig lspconfig
             schema-store schemastore
             utils yazdan.lsp.utils}})

(defn setup []
  (let [schemas (schema-store.yaml.schemas)]
    (lspconfig.yamlls.setup {:on_attach utils.on_attach
                             :schema schemas
                             :schemaStore {:enable false
                                           :url ""}})))
