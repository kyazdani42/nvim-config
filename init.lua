require 'au'
require 'mappings'
require 'plugins'
require 'statusline'.setup()
require 'new-component'
_G.K = require 'k'
pcall(require, 'custom')

vim.g['aniseed#env'] = true
