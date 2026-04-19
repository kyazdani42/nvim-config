(module yazdan.lsp.languages.java
  {autoload {utils yazdan.lsp.utils}})

(defn setup []
  (vim.lsp.config :java_language_server {:on_attach utils.on_attach
                                         :cmd [:/usr/share/java/java-language-server/lang_server_linux.sh]
                                         :filetypes [:java]})
  (vim.lsp.enable :java_language_server))
