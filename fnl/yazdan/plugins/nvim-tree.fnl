(module yazdan.plugins.nvim-tree
  {autoload {nvim aniseed.nvim
             tree nvim-tree
             tree-api nvim-tree.api}})

(def- renderer-config {:group_empty true
                       :highlight_git false
                       :highlight_opened_files "none"
                       :indent_markers {:enable false}
                       :icons {:webdev_colors true
                               :git_placement :after
                               :padding " "
                               :symlink_arrow " ➛ "
                               :show {:file true
                                      :folder true
                                      :folder_arrow true
                                      :git true}
                               :glyphs {:default ""
                                        :folder {:default "" :open ""}
                                        :git {:unstaged "✗"
                                              :staged "✓"
                                              :unmerged ""
                                              :renamed "➜"
                                              :untracked "★"}}}})

(def- open-file-config {:quit_on_open false
                         :resize_window true
                         :window_picker {:enable true :exclude {:filetype ["packer" "qf"]}}})

(defn- on-tree-attach [bufnr]
  (tree-api.config.mappings.default_on_attach bufnr)
  (vim.keymap.set "n" "<C-t>" "<cmd>TLiveGrep<cr>" {:silent true :remap false :buffer bufnr}))

(tree.setup
  {:disable_netrw true
   :filesystem_watchers {:enable true :debounce_delay 100}
   :hijack_netrw  true
   :open_on_tab   true
   :diagnostics {:enable true
                 :show_on_dirs false
                 :icons {:warning "" :error "" :info "" :hint ""}}
   :hijack_cursor true
   :sync_root_with_cwd true
   :prefer_startup_root true
   :respect_buf_cwd false
   :hijack_unnamed_buffer_when_opening true
   :hijack_directories {:enable true :auto_open true}
   :update_focused_file {:enable true
                         :update_cwd true
                         :ignore_list ["fzf" "help" "git"]}
   :on_attach on-tree-attach
   :ignore_buf_on_tab_change [:git :man :help :Neogit "--graph" :Mailbox]
   :system_open {:cmd nil
                 :args {}}
   :filters {:dotfiles false
             :custom ["\\.git$"]
             :excluded nil}
   :view {:width 30
          :adaptive_size true
          :side "left"
          :preserve_window_proportions true}
   :log {:enable false :types {:all true}}
   :renderer renderer-config
   :git {:enable true
         :ignore true
         :timeout 400}
   :actions {:change_dir {:global true}
             :open_file open-file-config}})

(defn- open-tree [data]
  (let [dir? (= 1 (vim.fn.isdirectory data.file))
        file? (= 1 (vim.fn.filereadable data.file))
        ft (. (. vim.bo data.buf) :ft)
        no-name-buf? (and (= data.file "") (= "" ft))]
    (if no-name-buf?
      (tree-api.tree.toggle)
      (if dir?
        (tree-api.tree.toggle {:path data.file})
        (when (and file? (not (vim.tbl_contains [:git :gitcommit :man :help] ft)))
          (tree-api.tree.toggle {:path data.file :focus false :find_file true :update_root true}))))))

(nvim.create_autocmd [:VimEnter] {:callback open-tree})
