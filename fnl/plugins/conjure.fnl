(module plugins.web-devicons
  {autoload {nvim aniseed.nvim}})

(vim.cmd "let g:conjure#eval#inline_results=v:true")
(vim.cmd "let g:conjure#log#hud#enabled=v:false")
(vim.cmd "let g:conjure#highlight#enabled=v:true")
(vim.cmd "let g:conjure#highlight#group='Search'")
