(module yazdan.lsp.languages.haskell
  {autoload {utils yazdan.lsp.utils}})

(defn setup []
  (vim.lsp.config :hls {:on_attach utils.on_attach})
  (vim.lsp.enable :hls)) 
