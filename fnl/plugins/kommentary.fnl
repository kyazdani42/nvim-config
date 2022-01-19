(module plugins.kommentary
  {autoload {config kommentary.config}})

(set vim.g.kommentary_create_default_mappings false)
(config.setup :default {:prefer_single_line_comments true})
