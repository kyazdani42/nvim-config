(module yazdan.lsp.languages.python
  {autoload {utils yazdan.lsp.utils}})

(defn setup []
  (vim.lsp.config :pylsp {:on_attach utils.on_attach}
                    :settings {:pylsp {:black {:enabled true}
                                       :autopep8 {:enabled false}
                                       :yapf {:enabled false}
                                       ; linter options
                                       :flake8 {:enabled true}
                                       :pylint {:enabled false}
                                       :ruff  {:enabled false}
                                       :pyflakes {:enabled false}
                                       :pycodestyle  {:enabled false}
                                       ; type checker
                                       :pylsp_mypy {:enabled true
                                                    :report_progress true
                                                    :live_mode false}
                                       ; auto-completion options
                                       :jedi_completion {:fuzzy true}
                                       ; import sorting
                                       :isort {:enabled true}}})
  (vim.lsp.enable :pylsp))
