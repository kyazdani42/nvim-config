(module yazdan.lsp.languages.graphql
  {autoload {utils yazdan.lsp.utils}})

(defn setup []
  (vim.lsp.config :graphql {:on_attach utils.on_attach
                            :filetypes [:graphql]})
  (vim.lsp.enable :graphql))
