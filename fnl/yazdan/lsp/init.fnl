(module yazdan.lsp.init
  {autoload {a aniseed.core
             nvim aniseed.nvim
             cmp-nvim-lsp cmp_nvim_lsp ; needed to load cmp
             utils yazdan.utils
             hover yazdan.lsp.handlers.hover
             definition yazdan.lsp.handlers.definition}
   require {_ yazdan.lsp.diagnostics}})

(set vim.lsp.handlers.textDocument/definition definition.handler)
(set vim.lsp.handlers.textDocument/hover hover.handler)

(defn- get-setup-fn [lang]
  (. (require (.. "yazdan.lsp.languages." lang)) :setup))

(defn- get-buf-win [buf]
  (a.first (a.filter (fn [win] (= (nvim.win_get_buf win) buf)) (nvim.list_wins))))

(defn- get-winbar [win]
  (nvim.get_option_value :winbar {:win win}))

(vim.api.nvim_create_autocmd :LspProgress {:pattern "*" :callback (fn [info]
                                                                    (let [win (get-buf-win info.buf)]
                                                                      (if (= :begin info.data.result.value.kind)
                                                                        (nvim.set_option_value :winbar (.. (get-winbar win) " %#DiagnosticInfo#󱥸 Loading LSP server... %#Normal#") {:win win})
                                                                        (do
                                                                          (nvim.set_option_value :winbar (vim.fn.substitute (get-winbar win) " %#DiagnosticInfo#󱥸 Loading LSP server... %#Normal#" " %#DiagnosticOk# LSP server loaded ! %#Normal#" "") {:win win})
                                                                          (vim.defer_fn (fn []
                                                                                          (nvim.set_option_value :winbar (vim.fn.substitute (get-winbar win) " %#DiagnosticOk# LSP server loaded ! %#Normal#" "" "") {:win win}))
                                                                                        2500)))))})

(let [capabilities (cmp-nvim-lsp.default_capabilities (vim.lsp.protocol.make_client_capabilities))]
  (a.run!
    (lambda [lang] ((get-setup-fn lang) capabilities))
    [:lua :js :rust :go :graphql :haskell :nix :yaml :terraform :json :efm]))
