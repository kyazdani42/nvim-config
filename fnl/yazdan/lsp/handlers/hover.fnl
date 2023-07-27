(module yazdan.lsp.handlers.hover
  {autoload {a aniseed.core
             nvim aniseed.nvim}})

(def- popup-default-cfg
  {:relative "cursor"
   :border "single"
   :style "minimal"
   :zindex 100
   :focusable true
   :noautocmd true
   :col 1
   :row 1})

(def- state {})

(defn- open-popup-window [lines]
  (let [curbuf (nvim.get_current_buf)
        buf (nvim.create_buf false true)
        win (nvim.open_win 0 false (a.merge popup-default-cfg {:width (vim.fn.max (vim.tbl_map #(length $1) lines))
                                                               :height (length lines)}))]
    (do
      (set state.win win)
      (nvim.buf_set_lines buf 0 -1 false lines)
      (nvim.set_option_value :filetype :markdown {:buf buf})
      (nvim.set_option_value :modifiable false {:buf buf})
      (nvim.set_option_value :conceallevel 3 {:win state.win})
      (nvim.set_option_value :wrap true {:win state.win})
      (nvim.win_set_buf state.win buf)
      (nvim.create_autocmd [:CursorMoved :InsertEnter :WinEnter :BufWinEnter]
                           {:once true
                            :buffer curbuf
                            :callback #(when (and (not (a.nil? state.win)) (nvim.win_is_valid state.win))
                                         (nvim.win_close state.win true)
                                         (set state.win nil))}))))

(defn handler [_ result ctx config]
  (when (= (nvim.get_current_buf) ctx.bufnr)
    (if (a.nil? state.win)
      (let [contents (?. result :contents)]
        (if (a.nil? contents)
          (vim.notify "No information available")
          (let [lines contents.value]
            (if (a.nil? lines)
              (vim.notify "No information available")
              (open-popup-window (vim.split (vim.trim contents.value) "\n"))))))
      (if (nvim.win_is_valid state.win)
        (nvim.set_current_win state.win)
        (do
          (set state.win nil)
          (handler nil result ctx config))))))
