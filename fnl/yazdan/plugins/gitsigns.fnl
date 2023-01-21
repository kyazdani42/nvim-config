(module yazdan.plugins.gitsigns
  {autoload {a aniseed.core
             nvim aniseed.nvim
             gitsigns gitsigns}})

(defn- nmap [bufnr lhs cb]
  (vim.keymap.set :n lhs cb {:buffer bufnr :remap false :silent true}))

(defn- attach-mappings [bufnr]
  (nmap bufnr "<leader>hs" gitsigns.preview_hunk)
  (nmap bufnr "<leader>ha" gitsigns.stage_hunk)
  (nmap bufnr "<leader>hu" gitsigns.undo_stage_hunk)
  (nmap bufnr "<leader>hr" gitsigns.reset_hunk)
  (nmap bufnr "<leader>hn" gitsigns.next_hunk)
  (nmap bufnr "<leader>hn" gitsigns.prev_hunk))

(defn- on-gitsigns-attach [bufnr]
  (if (not (a.nil? (string.match (nvim.buf_get_name bufnr) "NvimTree")))
    false
    (do
     (attach-mappings bufnr))))

(gitsigns.setup
  {:signs {:add          {:text "│"}
           :change       {:text "│"}
           :delete       {:text "│"}
           :topdelete    {:text "│"}
           :changedelete {:text "│"}
           :untracked    {:text "│"}}
   :numhl false
   :linehl false
   :word_diff false
   :watch_gitdir {:interval 1000}
   :current_line_blame false
   :current_line_blame_opts {:delay 500
                             :position "eol"}
   :sign_priority 6
   :update_debounce 200
   :status_formatter nil ; Use default
   :diff_opts {:internal true}
   :on_attach on-gitsigns-attach})
