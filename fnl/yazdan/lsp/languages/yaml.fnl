(module yazdan.lsp.languages.yaml
  {autoload {schema-store schemastore
             utils yazdan.lsp.utils}})

(defn setup []
  (let [schemas (schema-store.yaml.schemas)]
    (vim.lsp.config :yamlls {:on_attach utils.on_attach
                             :schema schemas
                             :schemaStore {:enable false :url ""}})
    (vim.lsp.enable :yamlls)))
