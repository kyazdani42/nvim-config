(module autocmd)

(defn autocmd [name where func]
  (vim.cmd (string.format "au %s %s %s" name where func)))

(autocmd "BufWinEnter" "*" (string.format "exec \"%s\"" "normal! g'\\\""))
(autocmd "TextYankPost" "*" "silent! lua require'vim.highlight'.on_yank({ timeout=500 })")
(autocmd "FileType" "scheme" "set ft=query")
(autocmd "BufNewFile,BufRead" "*.gql*.graphql" "set ft=graphql")
(autocmd "BufNewFile,BufRead" ".eslintrc" "set ft=json")
(autocmd "BufNewFile,BufRead" ".prettierrc" "set ft=json")
(autocmd "BufNewFile,BufRead" ".swcrc" "set ft=json")
(autocmd "FileType" "c,cpp" "set tabstop=8 shiftwidth=4 noexpandtab")
(autocmd "FileType" "python" "set tabstop=4 shiftwidth=4 noexpandtab")
(autocmd "FileType" "markdown" "set tabstop=4 shiftwidth=4 conceallevel=2")
(autocmd "FileType" "json,elixir,typescriptreact,typescript,javascript,javascriptreact,lua,html,css,graphql" "set tabstop=2 shiftwidth=2")
(autocmd "BufWritePost" "*.tex" ":silent !pdflatex % &>/dev/null")
