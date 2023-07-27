(module yazdan.lsp.progress
  {autoload {a aniseed.core
             nvim aniseed.nvim}})

(def- state {:win nil
             :is-ending? false})

(defn- get-buf-win [buf]
  (a.first (a.filter #(= (nvim.win_get_buf $1) buf) (nvim.list_wins))))

(defn- get-winbar []
  (nvim.get_option_value :winbar {:win state.win}))

(defn- set-winbar-msg [msg]
  (nvim.set_option_value :winbar msg {:win state.win}))

(def- const {:load-str " %#DiagnosticInfo#󱥸 Loading LSP server... %#Normal#"
             :ok-str " %#DiagnosticOk# LSP server loaded ! %#Normal#"
             :display-ok-duration 2500})

(defn- lsp-load-start [win]
  (set state.win win)
  (set-winbar-msg (.. (get-winbar state.win) const.load-str)))

(defn- lsp-load-end []
  (set state.is-ending? true)
  (set-winbar-msg (vim.fn.substitute (get-winbar) const.load-str const.ok-str ""))
  (vim.defer_fn #(do
                   (set-winbar-msg (vim.fn.substitute (get-winbar) const.ok-str "" ""))
                   (set state.is-ending? false)
                   (set state.win nil))
                const.display-ok-duration))

(defn- progress-handler [info]
  (let [win (get-buf-win info.buf)]
    (when (not state.is-ending?)
      (case info.data.result.value.kind
        :begin (when (a.nil? state.win)
                 (lsp-load-start win))
        :end (when (a.number? state.win)
               (lsp-load-end))))))

(nvim.create_autocmd :LspProgress {:pattern "*" :callback progress-handler})
