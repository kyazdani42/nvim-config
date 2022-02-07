(module plugins.kommentary
  {autoload {config kommentary.config}})

(set vim.g.kommentary_create_default_mappings false)
(config.configure_language :default {:prefer_single_line_comments true})
