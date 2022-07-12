(module lsp.utils
  {autoload {nvim aniseed.nvim
             help lspsaga.signaturehelp
             actions lspsaga.codeaction
             provider lspsaga.provider
             rename lspsaga.rename
             hover lspsaga.hover
             diags lsp.diagnostics
             telescope telescope.builtin}})

(defn- map [bufnr mode left right]
  (vim.keymap.set mode left right {:buffer bufnr :noremap true :silent true}))

(defn on_attach [_ bufnr]
  (let [nmap (partial map bufnr "n")
        vmap (partial map bufnr "v")]

    (nmap "<leader>ls" help.signature_help)
    (nmap "<leader>ca" actions.code_action)
    (vmap "<leader>ca" actions.range_code_action)
    (nmap "<leader>gd" provider.preview_definition)
    (nmap "<leader>rn" rename.rename)
    (nmap "K"          hover.render_hover_doc)
    (nmap "gD"         vim.lsp.buf.declaration)
    (nmap "gd"         vim.lsp.buf.definition)
    (nmap "gy"         vim.lsp.buf.type_definition)
    (nmap "gi"         vim.lsp.buf.implementation)
    (nmap "<leader>s"  diags.prev-diagnostic)
    (nmap "<leader>d"  diags.next-diagnostic)
    (nmap "gr"         telescope.lsp_references)))
