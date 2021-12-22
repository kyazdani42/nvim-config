(module keymap
  {autoload {nvim aniseed.nvim}})

(fn map [mode lhs rhs opt]
  (nvim.set_keymap mode lhs rhs (or opt {})))

(local nmap (partial map "n"))
(local vmap (partial map "v"))
(local imap (partial map "i"))
(local _map (partial map ""))

(local nowait { :nowait true })
(local silent { :silent true })
(local noremap-silent { :noremap true :silent true })

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

(nmap "<leader>bd" ":lua K['delete-hidden-bufs']()<CR>" silent)

(nvim.ex.cabbrev "W" "w")
(nvim.ex.cabbrev "Xa" "xa")
(nvim.ex.cabbrev "X" "x")

(nvim.ex.command! "-nargs=0" "Format" ":lua vim.lsp.buf.formatting_sync()")
(nvim.ex.command! "Dnd" ":!dragon-drag-and-drop %")
