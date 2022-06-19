(module plugins.telescope
  {autoload {nvim aniseed.nvim
             telescope telescope
             actions telescope.actions
             sorters telescope.sorters
             builtin telescope.builtin}})

(def- ivy
  {:theme "ivy"
   :borderchars {:preview ["─" "│" "─" "│" "┌" "┐" "┘" "└"]}})

(telescope.setup 
  {:defaults {:prompt_prefix " "
              :layout_config {:height 15}
              :file_sorter  sorters.get_fzy_sorter
              :file_ignore_patterns [".git/*"]
              :mappings {:i {"<esc>" actions.close
                             "<C-j>" actions.move_selection_next
                             "<C-k>" actions.move_selection_previous}}}
   :pickers {:buffers ivy
             :find_files ivy
             :live_grep ivy
             :lsp_references ivy}})

(defn apply-colorscheme []
  (nvim.ex.highlight "TelescopeSelectionCaret guifg=#89ddff gui=bold")
  (nvim.ex.highlight "TelescopePromptPrefix   guifg=#89ddff gui=bold")
  (nvim.ex.highlight "TelescopeSelection      guifg=#ffffff gui=bold")
  (nvim.ex.highlight "TelescopeMultiSelection guifg=#b9a3eb")
  (nvim.ex.highlight "TelescopePromptBorder   guifg=#1b1e2b")
  (nvim.ex.highlight "TelescopeBorder         guifg=#32374d")
  (nvim.ex.highlight "TelescopePreviewBorder  guifg=#32374d")
  (nvim.ex.highlight "TelescopeResultsBorder  guifg=#444267")
  (nvim.ex.highlight "TelescopeMatching       guifg=#ffcb6b"))

(apply-colorscheme)

(defn- live-grep [dir]
  (let [finder (. builtin :live_grep)]
    (if dir
      (finder {:search_dirs [dir]})
      (finder))))

(defn live-grep-input []
  (vim.ui.input {:prompt "directory (optional): "
                 :completion :dir} live-grep))

(nvim.create_user_command :TLiveGrep live-grep-input {})

(nvim.create_autocmd :ColorScheme {:callback (. (require :plugins.telescope) :apply-colorscheme)})
