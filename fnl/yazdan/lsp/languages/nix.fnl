(module yazdan.lsp.languages.nix
  {autoload {utils yazdan.lsp.utils}})

(defn setup []
  (vim.lsp.config :rnix {:on_attach utils.on_attach})
  (vim.lsp.enable :rnix))
