(module yazdan.plugins.lsp-saga
  {autoload {lspsaga lspsaga}})

(lspsaga.init_lsp_saga
  {:use_saga_diagnostic_sign true
   :code_action_icon ""
   :code_action_prompt {:enable true
                        :sign true
                        :sign_priority 20
                        :virtual_text false}

   :rename_action_keys {:quit ["<C-c>" "<Esc>" "<C-j>"]
                        :exec "<CR>"}
   :border_style "single"
   :rename_prompt_prefix "➤"})
