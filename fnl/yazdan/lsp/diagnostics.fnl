(module yazdan.lsp.diagnostics
  {autoload {a aniseed.core
             nvim aniseed.nvim
             utils yazdan.utils}})

(def- icons {:error ""
             :warn ""
             :info ""
             :hint ""})

(vim.cmd (string.format "sign define DiagnosticSignError text=%s texthl=DiagnosticSignError linehl= numhl=" icons.error))
(vim.cmd (string.format "sign define DiagnosticSignWarn text=%s texthl=DiagnosticSignWarn linehl= numhl="   icons.warn))
(vim.cmd (string.format "sign define DiagnosticSignInfo text=%s texthl=DiagnosticSignInfo linehl= numhl="   icons.info))
(vim.cmd (string.format "sign define DiagnosticSignHint text=%s texthl=DiagnosticSignHint linehl= numhl="   icons.hint))

(def- severity-to-icon {vim.diagnostic.severity.WARN icons.warn
                        vim.diagnostic.severity.INFO icons.info
                        vim.diagnostic.severity.HINT icons.hint
                        vim.diagnostic.severity.ERROR icons.error})

(defn- format-diagnostics [diagnostic]
  (let [icon (. severity-to-icon diagnostic.severity)
        cfg {:message (.. icon " ")}]
    (when (not (a.nil? diagnostic.source))
      (set cfg.message (string.format "%s[%s]" cfg.message diagnostic.source)))
    (when (not (a.nil? diagnostic.code))
      (set cfg.message (string.format "%s[%s]" cfg.message diagnostic.code)))
    (if (vim.endswith cfg.message "]")
      (string.format "%s %s" cfg.message diagnostic.message)
      (string.format "%s%s" cfg.message diagnostic.message))))

(vim.cmd "hi DiagnosticFloatHeader guifg=#b6bcdd")

(vim.diagnostic.config {:underline false
                        :signs false
                        :update_in_insert false
                        :severity_sort true

                        :float {:border :single
                                :focusable false
                                :scope :line
                                :suffix ""
                                :source false
                                :format format-diagnostics
                                :header [" Diagnostics" "DiagnosticFloatHeader"]}

                        :virtual_text {:spacing 1
                                       :prefix " "
                                       :source false
                                       :severity {:min vim.diagnostic.severity.HINT}}})

(defn- to-diagnostic [func-next]
  (let [diagnostics (vim.diagnostic.get (nvim.get_current_buf))]
    (if (a.empty? diagnostics)
      (utils.warn "No Diagnostics")
      (func-next))))

(defn prev-diagnostic [] (to-diagnostic vim.diagnostic.goto_prev))
(defn next-diagnostic [] (to-diagnostic vim.diagnostic.goto_next))
