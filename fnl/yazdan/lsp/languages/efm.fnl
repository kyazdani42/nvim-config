(module yazdan.lsp.languages.efm
  {autoload {lspconfig lspconfig
             a         aniseed.core}})

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

(defn- root-pattern [fname ...]
  (((. (require :lspconfig.util) :root_pattern) ...) fname))

(defn- get-lua-root [fname]
  (let [location (root-pattern fname :.stylua.toml)]
    (when (not (a.nil? location))
      location)))

(defn setup []
  (lspconfig.efm.setup {:filetypes filetypes
                        :on_attach (lambda [client]
                                     (set client.server_capabilities.documentFormattingProvider true))
                        :root_dir (lambda [fname] (get-lua-root fname))
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
                                               :lua [lua-cmd]}}}))
