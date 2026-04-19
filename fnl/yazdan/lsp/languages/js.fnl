(module yazdan.lsp.languages.ecma
  {autoload {utils yazdan.lsp.utils}})

(def- filetypes [:javascript :javascriptreact :javascript.jsx :typescript :typescriptreact :typescript.tsx])

(defn setup [capabilities]
  (when (= 1 (vim.fn.executable :typescript-language-server))
    (do
      (vim.lsp.config :ts_ls {:capabilities capabilities
                              :cmd [:typescript-language-server :--stdio]
                              :filetypes filetypes
                              :on_attach (lambda [client bufnr]
                                           (set client.server_capabilities.documentFormattingProvider false)
                                           (set client.server_capabilities.documentRangeFormattingProvider false)
                                           (utils.on_attach client bufnr))})
      (vim.lsp.enable [:tailwindcss :eslint :ts_ls]))))
