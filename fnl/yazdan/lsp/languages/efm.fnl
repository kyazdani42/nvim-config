(module yazdan.lsp.languages.efm
  {autoload {a aniseed.core}})

(def- prettier-cmd {:formatCommand "prettier --stdin-filepath ${INPUT}"
                    :formatStdin true})

(def- lua-cmd {:formatCommand "stylua -"
               :formatStdin true})

(def- filetypes
  [:javascript
   :javascriptreact
   :javascript.jsx
   :typescript
   :typescriptreact
   :typescript.tsx
   :graphql
   :css
   :html
   :json
   :jsonc
   :lua])

(defn setup []
  (do
    (vim.lsp.config :efm {:filetypes filetypes
                          :on_attach (lambda [client]
                                       (set client.server_capabilities.documentFormattingProvider true))
                          :settings {:languages {:javascript [prettier-cmd]
                                                 :javascriptreact [prettier-cmd]
                                                 :javascript.jsx [prettier-cmd]
                                                 :typescript [prettier-cmd]
                                                 :typescriptreact [prettier-cmd]
                                                 :typescript.tsx [prettier-cmd]
                                                 :css [prettier-cmd]
                                                 :html [prettier-cmd]
                                                 :json [prettier-cmd]
                                                 :jsonc [prettier-cmd]
                                                 :lua [lua-cmd]}}})
    (vim.lsp.enable :efm)))
