(module yazdan.lsp.diagnostics
  {autoload {a aniseed.core
             nvim aniseed.nvim
             utils yazdan.utils
             saga lspsaga.diagnostic}})

(vim.cmd "sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=")
(vim.cmd "sign define DiagnosticSignWarn text=𥉉 texthl=DiagnosticSignWarn linehl= numhl=")
(vim.cmd "sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=")
(vim.cmd "sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=")

(set vim.lsp.handlers.textDocument/publishDiagnostics
     (vim.lsp.with vim.lsp.diagnostic.on_publish_diagnostics 
                   {:underline false
                    :signs false
                    :virtual_text {:spacing 1 :prefix " "}}))

(defn- to-diagnostic [where]
  (let [diagnostics (vim.diagnostic.get (nvim.get_current_buf))]
    (if (a.empty? diagnostics)
      (utils.warn "No Diagnostics")
      ((saga.navigate where)))))

(defn prev-diagnostic [] (to-diagnostic "prev"))
(defn next-diagnostic [] (to-diagnostic "next"))
