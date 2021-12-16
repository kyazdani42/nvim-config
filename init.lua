require 'mappings'
require 'plugins'
require 'statusline'.setup()
require 'new-component'
pcall(require, 'custom')

vim.g['aniseed#env'] = true
