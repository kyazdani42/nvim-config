(module lsp.languages.json
  {autoload {lspconfig lspconfig
             schema-store schemastore
             utils lsp.utils}})

(defn setup [capabilities]
  (let [schemas (schema-store.json.schemas)]
    (lspconfig.jsonls.setup {:on_attach utils.on_attach
                             :capabilities capabilities
                             :init_options {:provideFormatter false}
                             :settings {:json {:schemas schemas
                                               :validate {:enable true}}}})))
