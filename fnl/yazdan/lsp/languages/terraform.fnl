(module yazdan.lsp.languages.terraform
  {autoload {utils yazdan.lsp.utils}})

(defn setup []
  (vim.lsp.enable :terraformls)
  (vim.lsp.config :terraformls {:on_attach utils.on_attach}))
