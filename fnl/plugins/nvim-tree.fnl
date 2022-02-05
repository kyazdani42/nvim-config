(module plugins.nvim-tree
  {autoload {nvim aniseed.nvim
             tree nvim-tree}})

(set nvim.g.nvim_tree_show_icons 
     {:git 1
      :folders 1
      :files 1
      :folder_arrows 1})

(set nvim.g.nvim_tree_group_empty 1)
(set nvim.g.nvim_tree_window_picker_exclude 
     {:filetype ["packer"
                 "qf"
                 "Trouble"]})
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
   :update_to_buf_dir {:enable true
                       :auto_open true}
   :diagnostics {:enable true :show_on_dirs false}
   :auto_close    false
   :hijack_cursor true
   :update_cwd    true
   :update_focused_file {:enable true
                         :update_cwd true
                         :ignore_list ["fzf" "help" "git"]}
   :ignore_ft_on_setup ["git" "man" "help"]
   :system_open {:cmd nil
                 :args {}}
   :filters {:dotfiles false :custom [".git" "node_modules" "dist"]}
   :view {:width 35
          :side "left"
          :hide_root_folder false
          :auto_resize true
          :mappings {:custom_only false
                     :list [{:mode "n"
                             :key "<C-t>" 
                             :cb "<cmd>lua require'telescope.builtin'.live_grep()<cr>"}]}}
   :git {:enable true
         :ignore true
         :timeout 400}}
  :actions {:change_dir {:global false}})
