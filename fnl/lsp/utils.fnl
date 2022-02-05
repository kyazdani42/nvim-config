(module lsp.utils
  {autoload {nvim aniseed.nvim}})

(local noremap-silent {:noremap true :silent true})

(fn buf-map [bufnr ...]
  (let [p [...]]
    (nvim.buf_set_keymap bufnr (?. p 1) (?. p 2) (?. p 3) noremap-silent)))

(defn on_attach [_ bufnr]
  (let [map (partial buf-map bufnr)
        nmap (partial map "n")
        vmap (partial map "v")]
    (nmap "K"          "<cmd>lua require'lspsaga.hover'.render_hover_doc()<CR>")
    (nmap "<leader>cc" "<cmd>lua require'lspsaga.signaturehelp'.signature_help()<CR>")
    (nmap "<leader>ca" "<cmd>lua require'lspsaga.codeaction'.code_action()<CR>")
    (vmap "<leader>ca" "<cmd>lua require'lspsaga.codeaction'.range_code_action()<CR>")
    (nmap "<leader>gd" "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>")
    (nmap "<leader>rn" "<cmd>lua require'lspsaga.rename'.rename()<CR>")

    (nmap "gr"         "<cmd>lua require('telescope.builtin').lsp_references()<cr>")
    (nmap "gD"         "<cmd>lua vim.lsp.buf.declaration()<CR>")
    (nmap "gd"         "<cmd>lua vim.lsp.buf.definition()<CR>")
    (nmap "gy"         "<cmd>lua vim.lsp.buf.type_definition()<CR>")
    (nmap "gi"         "<cmd>lua vim.lsp.buf.implementation()<CR>")

    (nmap "<leader>s"  "<cmd>lua require'lsp.diagnostics'['prev-diagnostic']()<CR>")
    (nmap "<leader>d"  "<cmd>lua require'lsp.diagnostics'['next-diagnostic']()<CR>")))
