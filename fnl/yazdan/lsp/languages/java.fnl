(module yazdan.lsp.languages.java
  {autoload {lspconfig lspconfig
             utils yazdan.lsp.utils}})

(defn setup []
  (lspconfig.java_language_server.setup {:on_attach utils.on_attach
                                         :cmd [:/usr/share/java/java-language-server/lang_server_linux.sh]
                                         :filetypes [:java]}))
