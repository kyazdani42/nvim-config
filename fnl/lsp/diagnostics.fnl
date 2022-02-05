(module lsp.diagnostics
  {autoload {a aniseed.core
             nvim aniseed.nvim}})

(vim.cmd "sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=")
(vim.cmd "sign define DiagnosticSignWarn text=⚠ texthl=DiagnosticSignWarn linehl= numhl=")
(vim.cmd "sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=")
(vim.cmd "sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=")

(set vim.lsp.handlers.textDocument/publishDiagnostics
     (vim.lsp.with vim.lsp.diagnostic.on_publish_diagnostics 
                   {:underline false
                    :signs false
                    :virtual_text {:spacing 1 :prefix " "}}))

(defn- warn-no-diagnostics []
  (. (require "utils") :warn) "No Diagnostics")

(defn- navigate-to [where]
  (((. (require "lspsaga.diagnostic") :navigate) where)))

(defn- to-diagnostic [where]
  (let [diagnostics (vim.diagnostic.get (nvim.get_current_buf))]
    (if (a.empty? diagnostics)
      (warn-no-diagnostics)
      (navigate-to where))))

(def prev-diagnostic (lambda [] (to-diagnostic "prev")))
(def next-diagnostic (lambda [] (to-diagnostic "next")))
