(module yazdan.autocmd
  {autoload {nvim aniseed.nvim
             a    aniseed.core
             env  aniseed.env
             cs   ts_context_commentstring.internal}})

(def- group (nvim.create_augroup :K {:clear true}))

(defn- autocmd [name opts]
  (nvim.create_autocmd name (a.merge! {:group group} opts)))

(autocmd :BufWinEnter  {:callback (lambda [] (vim.cmd "silent! normal! g'\""))})
(autocmd :TextYankPost {:callback (lambda [] (vim.highlight.on_yank {:timeout 500}))})
(autocmd :BufEnter {:callback (lambda [] (vim.opt_local.formatoptions:remove ["c" "r" "o"]))})

(when (pcall require :ts_context_commenstring_internal)
  (autocmd :CursorHold {:callback cs.update_commentstring}))

(autocmd [:BufNewFile :BufRead] {:pattern [".eslintrc" ".prettierrc" ".swcrc"]
                                 :callback (lambda [] (set vim.opt_local.filetype :json))})

(autocmd :BufWritePost {:pattern "*.tex" :command ":silent !pdflatex % &>/dev/null"})

(def- disabled-filetypes ["NvimTree" "TelescopePrompt" "NeogitStatus" "fugitiveblame" "git" "man" "packer" "lspinfo"])

(autocmd :Filetype {:callback (lambda []
                                 (let [ft vim.bo.filetype]
                                   (if (vim.tbl_contains disabled-filetypes ft) 
                                     (set vim.wo.winbar " ")
                                     (set vim.wo.winbar "%m %f"))))})

(autocmd :BufWritePost
         {:pattern "*.fnl"
          :callback (lambda []
                      (env.init nvim.g.aniseed#env))})
