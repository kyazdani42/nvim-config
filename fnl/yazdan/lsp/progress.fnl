(module yazdan.lsp.progress
  {autoload {a aniseed.core
             nvim aniseed.nvim}})

(def- state {:win nil
             :winbar ""
             :is-ending? false})

(defn- get-buf-win [buf]
  (a.first (a.filter #(= (nvim.win_get_buf $1) buf) (nvim.list_wins))))

(defn- get-winbar []
  (if (nvim.win_is_valid state.win)
    (nvim.get_option_value :winbar {:win state.win})
    ""))

(defn- set-winbar-msg [msg]
  (when (nvim.win_is_valid state.win)
    (nvim.set_option_value :winbar msg {:win state.win})))

(def- const {:load-str #(.. " %#DiagnosticInfo#󱥸 " (or $1 0) "%% Loading LSP server... %#Normal#")
             :ok-str " %#DiagnosticOk# LSP server loaded ! %#Normal#"
             :display-ok-duration 2500})

(defn- lsp-load-start [percentage]
  (set-winbar-msg (string.format "%s%s" state.winbar (const.load-str percentage))))

(defn- lsp-load-end []
  (set state.is-ending? true)
  (set-winbar-msg (string.format "%s%s" state.winbar const.ok-str))
  (vim.defer_fn #(do
                   (set-winbar-msg (vim.fn.substitute (get-winbar) const.ok-str "" ""))
                   (set state.is-ending? false)
                   (set state.winbar "")
                   (set state.win nil))
                const.display-ok-duration))

(defn- progress-handler [info]
  (let [win (get-buf-win info.buf)
        data (?. info.data :result :value)]
    (when (not state.is-ending?)
      (if (and data (not= data.kind "end"))
        (do
          (when (a.nil? state.win)
            (set state.win win)
            (set state.winbar (get-winbar win)))
          (lsp-load-start data.percentage))
        (when (a.number? state.win)
          (lsp-load-end))))))

(nvim.create_autocmd :LspProgress {:pattern "*" :callback progress-handler})
