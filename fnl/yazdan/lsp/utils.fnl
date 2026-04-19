(module yazdan.lsp.utils
  {autoload {a aniseed.core
             nvim aniseed.nvim
             diags yazdan.lsp.diagnostics
             help lspsaga.signaturehelp
             provider lspsaga.provider
             rename lspsaga.rename
             telescope telescope.builtin}})

(defn- map [bufnr mode left right]
  (vim.keymap.set mode left right {:buffer bufnr :noremap true :silent true}))

(defn- format [] (do
                   (vim.lsp.buf.format {:timeout_ms 2000 :async false})
                   (when (> 0 (vim.fn.exists ":LspEslintFixAll"))
                     (vim.cmd "LspEslintFixAll"))))


(defn- onlist [options]
  (do
    (vim.fn.setqflist {} " " options)
    (vim.cmd.cfirst)))

(defn on_attach [_ bufnr]
  (let [nmap (partial map bufnr "n")
        vmap (partial map bufnr "v")]

    (nmap "<leader>ls" vim.lsp.buf.signature_help)
    (nmap "<leader>rn" vim.lsp.buf.rename)
    (nmap "<leader>ca" vim.lsp.buf.code_action)
    (nmap "K"          vim.lsp.buf.hover)
    (nmap "gd"         vim.lsp.buf.type_definition)
    (nmap "<C-]>"      (partial vim.lsp.buf.definition {:on_list onlist}))
    (nmap "<leader>dp" diags.prev-diagnostic)
    (nmap "<leader>dn" diags.next-diagnostic)
    (nmap "gr"         telescope.lsp_references)
    (nmap "<leader>ff" format)))
