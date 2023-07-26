(module yazdan.lsp.utils
  {autoload {nvim aniseed.nvim
             diags yazdan.lsp.diagnostics

             help lspsaga.signaturehelp
             provider lspsaga.provider
             rename lspsaga.rename

             telescope telescope.builtin}})

(defn- map [bufnr mode left right]
  (vim.keymap.set mode left right {:buffer bufnr :noremap true :silent true}))

(defn- format [] (vim.lsp.buf.format {:timeout_ms 2000 :async false}))

(defn on_attach [_ bufnr]
  (let [nmap (partial map bufnr "n")
        vmap (partial map bufnr "v")]

    ; saga
    (nmap "<leader>ls" help.signature_help)
    (nmap "<leader>gd" provider.preview_definition)
    (nmap "<leader>rn" rename.rename)

    (nmap "<leader>ca" vim.lsp.buf.code_action)
    (nmap "K"          vim.lsp.buf.hover)
    (nmap "gd"         vim.lsp.buf.type_definition)
    (nmap "<C-]>"      vim.lsp.buf.definition)
    (nmap "<leader>dp" diags.prev-diagnostic)
    (nmap "<leader>dn" diags.next-diagnostic)
    (nmap "gr"         telescope.lsp_references)
    (nmap "<leader>ff" format)))
