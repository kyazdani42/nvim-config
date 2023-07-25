(module yazdan.lsp.handlers.hover
  {autoload {a aniseed.core}})

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
  (let [curbuf (vim.api.nvim_get_current_buf)
        buf (vim.api.nvim_create_buf false true)
        win (vim.api.nvim_open_win 0 false (a.merge popup-default-cfg {:width (vim.fn.max (vim.tbl_map (fn [n] (# n)) lines))
                                                                       :height (# lines)}))]
    (do
      (set state.win win)
      (vim.api.nvim_buf_set_lines buf 0 -1 false lines)
      (vim.api.nvim_set_option_value :filetype :markdown {:buf buf})
      (vim.api.nvim_set_option_value :modifiable false {:buf buf})
      (vim.api.nvim_set_option_value :conceallevel 3 {:win state.win})
      (vim.api.nvim_set_option_value :wrap true {:win state.win})
      (vim.api.nvim_win_set_buf state.win buf)
      (vim.api.nvim_create_autocmd [:CursorMoved :InsertEnter :WinEnter :BufWinEnter]
                                   {:once true
                                    :buffer curbuf
                                    :callback (fn []
                                                (when (and (not (a.nil? state.win)) (vim.api.nvim_win_is_valid state.win))
                                                  (vim.api.nvim_win_close state.win true)
                                                  (set state.win nil)))}))))

(defn handler [_ result ctx config]
  (when (= (vim.api.nvim_get_current_buf) ctx.bufnr)
    (if (a.nil? state.win)
      (let [contents (?. result :contents)]
        (if (a.nil? contents)
          (vim.notify "No information available")
          (let [lines contents.value]
            (if (a.nil? lines)
              (vim.notify "No information available")
              (open-popup-window (vim.split (vim.trim contents.value) "\n"))))))
      (if (vim.api.nvim_win_is_valid state.win)
        (vim.api.nvim_set_current_win state.win)
        (do
          (set state.win nil)
          (handler nil result ctx config))))))
