(module mappings
  {autoload {nvim aniseed.nvim}})

(defn- map [mode lhs rhs opt]
  (nvim.set_keymap mode lhs rhs (or opt {})))

(def- nmap (partial map "n"))
(def- vmap (partial map "v"))
(def- imap (partial map "i"))
(def- _map (partial map ""))

(def- nowait { :nowait true})
(def- silent { :silent true})
(def- noremap-silent { :noremap true :silent true})

(_map "<C-j>" "" nowait)
(imap "<C-j>" "<ESC>" nowait)
(vmap "<C-j>" "<ESC>" nowait)

(nmap "<C-j>" "<C-w>j")
(nmap "<C-k>" "<C-w>k")
(nmap "<C-l>" "<C-w>l")
(nmap "<C-h>" "<C-w>h")

(nmap "<leader>v" ":noh<CR>" silent)

(nmap "j" "gj")
(nmap "k" "gk")
(nmap "<leader><leader>" "<c-^>")
(nmap "<leader>tn" ":tabnext<CR>")

(nmap "Q" "")
(nmap "<F1>" "")
(imap "<F1>" "")

(nmap "<C-u>" "<C-u>zz")
(nmap "<C-d>" "<C-d>zz")
(nmap "<C-f>" "<C-f>zz")

(nmap "<tab>" ":normal za<cr>" noremap-silent)

(nmap "<leader>tt" "<cmd>Trouble<cr>" silent)
(nmap "<leader>td" "<cmd>Trouble lsp_definitions<cr>" silent)
(nmap "<leader>tr" "<cmd>Trouble lsp_references<cr>" silent)

(nmap "<leader>gg" "<cmd>Neogit<cr>" silent)
(nmap "<leader>gb" "<cmd>Git blame<cr>" silent)

(nmap "<leader>bd" "<cmd>lua K['delete-hidden-bufs']()<cr>" silent)
(nmap "<leader>bp" "<cmd>bprev<cr>" silent)
(nmap "<leader>bn" "<cmd>bnext<cr>" silent)

(nmap "<C-n>" ":NvimTreeToggle<CR>" noremap-silent)
(nmap "<leader>r" ":NvimTreeRefresh<CR>" noremap-silent)

(nmap "<C-p>" "<cmd>lua require('telescope.builtin').find_files()<CR>" noremap-silent)
(nmap "<C-b>" "<cmd>lua require('telescope.builtin').buffers()<CR>" noremap-silent)
(nmap "<C-t>" "<cmd>lua require('telescope.builtin').live_grep()<CR>" noremap-silent)
(nmap "<leader>p" "<cmd>Telescope repo list<cr>" silent)

(nmap "R" ":write | edit | TSBufEnable highlight<CR>")

(nvim.ex.cabbrev "W" "w")
(nvim.ex.cabbrev "Xa" "xa")
(nvim.ex.cabbrev "X" "x")

(nvim.ex.command! "-nargs=0" "Format" ":lua vim.lsp.buf.formatting_sync()")
(nvim.ex.command! "Dnd" ":!dragon %")

(nmap "++" "<Plug>kommentary_line_default" silent)
(vmap "++" "<Plug>kommentary_visual_default" silent)
