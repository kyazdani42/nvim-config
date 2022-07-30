(module yazdan.autocmd
  {autoload {nvim aniseed.nvim
             a    aniseed.core
             env  aniseed.env
             cs   ts_context_commentstring.internal}})

(def- group (nvim.create_augroup :K {:clear true}))

(defn- autocmd [name opts]
  (nvim.create_autocmd name (a.merge! {:group group} opts)))

(autocmd :BufWinEnter  {:command (string.format "exec \"%s\"" "normal! g'\\\"")})
(autocmd :TextYankPost {:callback (lambda [] (vim.highlight.on_yank {:timeout 500}))})

(autocmd [:BufNewFile :BufRead] {:pattern [".eslintrc" ".prettierrc" ".swcrc"]
                                 :command "set ft=json"})

; avoid autocommenting on newline.
; needs autocmd because option is local to buffer.
(autocmd :BufEnter  {:command "setlocal formatoptions-=cro"})
(autocmd :CursorHold  {:callback (lambda [] (cs.update_commentstring))})
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
