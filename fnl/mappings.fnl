(module mappings
  {autoload {nvim aniseed.nvim
             harpoon-ui harpoon.ui
             harpoon-mark harpoon.mark
             telescope telescope.builtin
             nvim-tree nvim-tree
             refactoring refactoring}})

(defn- map [mode lhs rhs opt]
  (vim.keymap.set mode lhs rhs (or opt {:noremap true :silent true})))

(def- nmap (partial map "n"))
(def- vmap (partial map "v"))
(def- imap (partial map "i"))
(def- _map (partial map ""))

(def- nowait {:nowait true})
(def- silent {:silent true})

(_map "<C-j>" "" nowait)
(imap "<C-j>" "<ESC>" nowait)
(vmap "<C-j>" "<ESC>" nowait)

(nmap "<C-j>" "<C-w>j" {})
(nmap "<C-k>" "<C-w>k" {})
(nmap "<C-l>" "<C-w>l" {})
(nmap "<C-h>" "<C-w>h" {})

(nmap "j" "gj" {})
(nmap "k" "gk" {})

(nmap "<leader><leader>" "<c-^>" {})
(nmap "<leader>tn" ":tabnext<CR>" {})

(nmap "Q" "" {})
(nmap "<F1>" "" {})
(imap "<F1>" "" {})

(nmap "<leader>v" ":noh<CR>" silent)

(nmap "<C-u>" "<C-u>zz")
(nmap "<C-d>" "<C-d>zz")
(nmap "<C-f>" "<C-f>zz")

(nmap "<tab>" ":normal za<cr>")

(nmap "<leader>tt" "<cmd>Trouble<cr>" silent)
(nmap "<leader>td" "<cmd>Trouble lsp_definitions<cr>" silent)
(nmap "<leader>tr" "<cmd>Trouble lsp_references<cr>" silent)

(nmap "<leader>gg" "<cmd>Neogit<cr>" silent)
(nmap "<leader>gb" "<cmd>Git blame<cr>" silent)

(nmap "<leader>bd" (lambda [] (K.delete-hidden-bufs)) silent)
(nmap "<leader>bp" "<cmd>bprev<cr>")
(nmap "<leader>bn" "<cmd>bnext<cr>")
(nmap "<leader>bb" harpoon-ui.toggle_quick_menu) 
(nmap "<leader>bt" "<cmd>Telescope harpoon marks<CR>")
(nmap "<leader>bm" harpoon-mark.add_file)

(nmap "<C-n>" nvim-tree.toggle)

(nmap "<C-p>" (lambda [] (telescope.find_files {:hidden true})))
(nmap "<C-b>" telescope.buffers)
(nmap "<C-t>" "<cmd>TLiveGrep<CR>")

(nmap "<leader>f" (lambda [] (vim.lsp.buf.format {:timeout_ms 2000 :async false})))

(nmap "R" "<cmd>write | edit | TSBufEnable highlight<CR>")

(nmap "++" "<Plug>kommentary_line_default" silent)
(vmap "++" "<Plug>kommentary_visual_default" silent)

(defn- refactor [s] (lambda [] (refactoring.refactor s)))
(vmap "<leader>ref"  (refactor "Extract Function"))
(vmap "<leader>reff" (refactor "Extract Function To File"))
(vmap "<leader>rev"  (refactor "Extract Variable"))
(vmap "<leader>riv"  (refactor "Inline Variable"))
(nmap "<leader>riv"  (refactor "Inline Variable"))
(nmap "<leader>reb"  (refactor "Extract Block"))
(nmap "<leader>rebf" (refactor "Extract Block To File"))

(nvim.ex.cabbrev "W" "w")
(nvim.ex.cabbrev "Xa" "xa")
(nvim.ex.cabbrev "X" "x")
(nvim.ex.command! "Dnd" ":!dragon %")
