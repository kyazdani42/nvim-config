(module lsp.languages.efm
  {autoload {lspconfig lspconfig
             utils     lsp.utils
             a         aniseed.core}})

(def- eslint-cmd {:formatStdin true
                  :lintCommand "eslint_d -f unix --stdin --stdin-filename ${INPUT}"
                  :lintStdin true
                  :lintFormats ["%f:%l:%c: %m"]
                  :lintIgnoreExitCode true
                  :formatCommand "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}"})

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

(defn- get-eslint-root [fname]
  (let [eslintrc-root (root-pattern fname :.eslintrc :.eslintrc.json :.eslintrc.js)
        package-json-root (root-pattern fname "package.json")
        package-json (.. (or package-json-root "") "/package.json")]
    (if (not (a.nil? eslintrc-root))
      eslintrc-root
      (when (and (not (a.nil? package-json-root)) (vim.loop.fs_access package-json :R))
        (let [(ok? decoded) (pcall vim.fn.json_decode (vim.fn.readfile package-json))]
          (when (and ok? (. decoded :eslintConfig))
            package-json-root))))))

(defn- get-lua-root [fname]
  (when (not (a.nil? (root-pattern fname :.stylua.toml)))
    (root-pattern fname :.stylua.toml)))

(defn- setup-linter []
  (lspconfig.efm.setup {:filetypes filetypes
                        :on_attach (lambda [client]
                                     (set client.server_capabilities.documentFormattingProvider true)
                                     (set client.server_capabilities.gotoDefinition false))
                        :root_dir (lambda [fname]
                                    (or (get-lua-root fname) (get-eslint-root fname)))
                        :settings {:languages {:javascript [eslint-cmd prettier-cmd]
                                               :javascriptreact [eslint-cmd prettier-cmd]
                                               :javascript.jsx [eslint-cmd prettier-cmd]
                                               :typescript [eslint-cmd prettier-cmd]
                                               :typescript.tsx [eslint-cmd prettier-cmd]
                                               :typescriptreact [eslint-cmd prettier-cmd]
                                               :json [prettier-cmd]
                                               :jsonc [prettier-cmd]
                                               :lua [lua-cmd]}}}))

(defn setup [capabilities]
  (setup-linter))
