(module yazdan.lsp.languages.json
  {autoload {schema-store schemastore
             utils yazdan.lsp.utils}})

(defn setup [capabilities]
  (let [schemas (schema-store.json.schemas)]
    (vim.lsp.config :jsonls {:on_attach utils.on_attach}
           :capabilities capabilities
           :init_options {:provideFormatter false}
           :settings {:json {:schemas schemas
                             :validate {:enable true}}})
    (vim.lsp.enable :jsonls)))
