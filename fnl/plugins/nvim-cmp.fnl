(module plugins.nvim-cmp
  {autoload {nvim aniseed.nvim
             lspkind lspkind
             cmp cmp}})

(lspkind.init)

(fn complete []
  (if (not (cmp.visible))
    (cmp.complete)))

(fn snip [args]
  ((. nvim.fn "vsnip#anonymous") args.body))

(cmp.setup
  {:snippet {:expand snip}
   :mapping {"<C-u>" (cmp.mapping.scroll_docs -4)
             "<C-d>" (cmp.mapping.scroll_docs 4)
             "<C-c>" (cmp.mapping.close)
             "<CR>" (cmp.mapping.confirm 
                      {:select false
                       :behavior cmp.ConfirmBehavior.Insert})
             "<c-space>" (cmp.mapping 
                           {:i (cmp.mapping.complete)
                            :c complete})}
   :sources [{:name "nvim_lua"}
             {:name "nvim_lsp"}
             {:name "path" :keyword_length 4 }
             {:name "buffer" :keyword_length 6 }]

   :formatting {:format (lspkind.cmp_format 
                          {:with_text true
                           :menu {:buffer "[Buf]"
                                  :nvim_lsp "[LSP]"
                                  :nvim_lua "[api]"
                                  :path "[path]"}})}
   :experimental {:native_menu false
                  :ghost_text true}})
