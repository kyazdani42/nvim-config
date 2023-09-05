(module yazdan.lsp.init
  {autoload {a aniseed.core
             nvim aniseed.nvim
             cmp-nvim-lsp cmp_nvim_lsp ; needed to load cmp
             utils yazdan.utils
             hover yazdan.lsp.handlers.hover
             definition yazdan.lsp.handlers.definition
             signature yazdan.lsp.handlers.signature}
   require {_ yazdan.lsp.diagnostics
            _ yazdan.lsp.progress}})

(set vim.lsp.handlers.textDocument/definition definition.handler)
(set vim.lsp.handlers.textDocument/hover hover.handler)
(set vim.lsp.handlers.textDocument/signatureHelp signature.handler)

(defn- get-setup-fn [lang]
  (. (require (.. "yazdan.lsp.languages." lang)) :setup))

(let [capabilities (cmp-nvim-lsp.default_capabilities (vim.lsp.protocol.make_client_capabilities))]
  (a.run!
    (lambda [lang] ((get-setup-fn lang) capabilities))
    [:lua :js :rust :go :graphql :haskell :nix :yaml :terraform :json :efm]))
