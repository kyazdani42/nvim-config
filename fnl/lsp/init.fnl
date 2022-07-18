(module lsp.init
  {autoload {a aniseed.core
             nvim aniseed.nvim
             utils utils
             cmp-nvim-lsp cmp_nvim_lsp}
   require {_ lsp.diagnostics}})

(defn- get-location-from [result]
  (if (vim.tbl_islist result) (a.first result) result))

(defn- jump-to [result]
  (vim.lsp.util.jump_to_location result :utf-8))

(defn- handler [err result]
  (if (a.string? err)
    (nvim.err_writln err)
    (let [res (get-location-from result)]
      (if (a.nil? res)
        (utils.warn "No definition found")
        (jump-to res)))))

(set vim.lsp.handlers.textDocument/definition handler)

(defn- get-setup-fn [lang]
  (. (require (.. "lsp.languages." lang)) :setup))

(let [capabilities (cmp-nvim-lsp.update_capabilities (vim.lsp.protocol.make_client_capabilities))]
  (a.run! 
    (lambda [lang] ((get-setup-fn lang) capabilities))
    [:lua :js :rust :go :graphql :haskell :nix :yaml :terraform :json :efm]))
