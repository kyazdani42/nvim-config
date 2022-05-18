(module plugins.nvim-tree
  {autoload {nvim aniseed.nvim
             tree nvim-tree}})

(set nvim.g.nvim_tree_show_icons 
     {:git 1
      :folders 1
      :files 1
      :folder_arrows 1})

(set nvim.g.nvim_tree_git_hl 0)

(set nvim.g.nvim_tree_highlight_opened_files 0)

(set nvim.g.nvim_tree_group_empty 1)
(set nvim.g.nvim_tree_icons 
     {:default ""
      :git {:unstaged "✗"
            :staged "✓"
            :unmerged ""
            :renamed "➜"
            :untracked "★"}
      :folder {:default ""
               :open ""}})

(tree.setup
  {:disable_netrw true
   :hijack_netrw  true
   :open_on_setup true
   :open_on_tab   true
   :diagnostics {:enable true :show_on_dirs false}
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
   :view {:width 35
          :side "left"
          :hide_root_folder false
          :mappings {:custom_only false
                     :list [{:mode "n"
                             :key "<C-t>" 
                             :cb "<cmd>TLiveGrep<cr>"}]}}
   :renderer {:indent_markers {:enable false}
              :icons {:webdev_colors true :git_placement :after}}
   :git {:enable true
         :ignore true
         :timeout 400}
   :actions {:change_dir {:global true}
             :open_file {:quit_on_open false
                         :resize_window true
                         :window_picker {:enable true
                                         :exclude {:filetype ["packer"
                                                               "qf"
                                                               "Trouble"]}}}}})
