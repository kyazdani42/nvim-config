require 'mappings'
require 'plugins'
require 'statusline'.setup()
pcall(require, 'custom')

vim.g['aniseed#env'] = true
