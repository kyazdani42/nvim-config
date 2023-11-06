(module yazdan.mappings
  {autoload {nvim aniseed.nvim
             telescope telescope.builtin
             nvim-tree nvim-tree.api}})

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

(nmap "<leader>gg" "<cmd>Git<cr>" silent)
(nmap "<leader>gb" "<cmd>Git blame<cr>" silent)

(nmap "<leader>bd" (lambda [] (K.delete-hidden-bufs)) silent)
(nmap "<leader>bp" "<cmd>bprev<cr>")
(nmap "<leader>bn" "<cmd>bnext<cr>")

(nmap "<C-n>" nvim-tree.tree.toggle)

(nmap "<C-p>" (lambda [] (telescope.find_files {:hidden true})))
(nmap "<C-b>" (lambda [] (telescope.buffers)))
(nmap "<C-t>" "<cmd>TLiveGrep<CR>")

(nmap "R" "<cmd>write | edit | TSBufEnable highlight<CR>")

(nmap "++" "<Plug>kommentary_line_default" silent)
(vmap "++" "<Plug>kommentary_visual_default" silent)

(nvim.ex.cabbrev "W" "w")
(nvim.ex.cabbrev "Xa" "xa")
(nvim.ex.cabbrev "X" "x")
(nvim.ex.command! "Dnd" ":!dragon %")

(nvim.create_user_command :TrimEnd ":%s/ *$//g | noh" {:bang true})
(nvim.create_user_command :StartTCR tcr.startup {:bang true :nargs 1 :complete "customlist,v:lua.require'yazdan.tcr'"})
