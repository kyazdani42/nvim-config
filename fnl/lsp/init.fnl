(module lsp.init
  {autoload {a aniseed.core
             nvim aniseed.nvim}
   require {_ lsp.diagnostics}})

(defn- warn-definition-not-found []
  ((. (require "utils") :warn) "No definition found"))

(defn- get-location-from [result]
  (if (vim.tbl_islist result) (first result) result))

(defn- jump-to [result]
  (vim.lsp.util.jump_to_location (get-location-from result)))

(defn- handler [err result]
  (if (a.string? err)
    (nvim.err_writln err)
    (if (a.nil? result)
      (warn-definition-not-found)
      (jump-to result))))

(set vim.lsp.handlers.textDocument/definition handler)

(let [cmp-nvim-lsp (require "cmp_nvim_lsp")
      capabilities (cmp-nvim-lsp.update_capabilities (vim.lsp.protocol.make_client_capabilities))]
  (a.run! 
    (lambda [lang] ((. (require (.. "lsp.languages." lang)) :setup) capabilities))
    [:lua :ecma :rust :go :graphql :haskell :rnix]))
