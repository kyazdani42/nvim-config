(module plugins.nvim-tree
  {autoload {nvim aniseed.nvim
             tree nvim-tree}})

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

(tree.setup
  {:disable_netrw true
   :filesystem_watchers {:enable true :interval 100}
   :hijack_netrw  true
   :open_on_setup true
   :open_on_tab   true
   :diagnostics {:enable true
                 :show_on_dirs false
                 :icons {:warning "𥉉" :error "" :info "" :hint ""}}
   :hijack_cursor true
   :update_cwd    true
   :hijack_unnamed_buffer_when_opening true
   :hijack_directories {:enable true :auto_open true}
   :update_focused_file {:enable true
                         :update_cwd true
                         :ignore_list ["fzf" "help" "git"]}
   :ignore_ft_on_setup ["git" "man" "help"]
   :system_open {:cmd nil
                 :args {}}
   :filters {:dotfiles false
             :custom ["\\.git$"]
             :excluded nil}
   :view {:width 30
          :adaptive_size true
          :side "right"
          :hide_root_folder false
          :mappings {:custom_only false
                     :list [{:key "<C-t>" 
                             :cb "<cmd>TLiveGrep<cr>"}]}}
   :log {:enable false :types {:git true :watcher true}}
   :renderer renderer-config
   :git {:enable true
         :ignore true
         :timeout 400}
   :actions {:change_dir {:global true}
             :open_file open-file-config}})
