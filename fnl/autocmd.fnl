(module autocmd
  {autoload {nvim aniseed.nvim
             a    aniseed.core
             cs   ts_context_commentstring.internal}})

(def- group (nvim.create_augroup :K {:clear true}))

(defn- autocmd [name opts]
  (nvim.create_autocmd name (a.merge! {:group group} opts)))

(autocmd :BufWinEnter  {:command (string.format "exec \"%s\"" "normal! g'\\\"")})
(autocmd :TextYankPost {:callback (lambda [] (vim.highlight.on_yank {:timeout 500}))})

(autocmd [:BufNewFile :BufRead] {:pattern [".eslintrc" ".prettierrc" ".swcrc"]
                                 :command "set ft=json"})

(autocmd :FileType {:pattern :scheme :command "set ft=query"})
(autocmd :FileType {:pattern [:c :cpp :python :rust] :command "set tabstop=4 shiftwidth=4 noexpandtab"})
(autocmd :FileType {:pattern "markdown" :command "set tabstop=4 shiftwidth=4 conceallevel=2"})
(autocmd :FileType {:pattern [:terraform :json :elixir :typescriptreact :typescript :javascript :javascriptreact :lua :html :css :graphql] 
                    :command "set tabstop=2 shiftwidth=2"})
; avoid autocommenting on newline.
; needs autocmd because option is local to buffer.
(autocmd :BufEnter  {:command "setlocal formatoptions-=cro"})
(autocmd :CursorHold  {:callback (lambda [] (cs.update_commentstring))})
(autocmd :BufWritePost {:pattern "*.tex" :command ":silent !pdflatex % &>/dev/null"})


(def- disabled-filetypes ["NvimTree" "TelescopePrompt" "NeogitStatus" "fugitiveblame" "git" "man" "packer"])

(autocmd :FileType {:callback (lambda []
                                (let [ft vim.o.filetype]
                                  (when (not (vim.tbl_contains disabled-filetypes ft)) 
                                    (vim.cmd ":setlocal winbar=%m\\ %f"))))})
