local function map(mode)
  return function (lhs, rhs, opt)
    vim.api.nvim_set_keymap(mode, lhs, rhs, opt or {})
  end
end

local nmap = map('n')
local vmap = map('v')
local imap = map('i')
local _map = map('')

vim.g.mapleader = '\\'

_map('<C-j>', '', { nowait = true })
imap('<C-j>', '<ESC>', { nowait = true })
vmap('<C-j>', '<ESC>', { nowait = true })

nmap('<C-j>', '<C-w>j')
nmap('<C-k>', '<C-w>k')
nmap('<C-l>', '<C-w>l')
nmap('<C-h>', '<C-w>h')

nmap('<leader>v', ':noh<CR>', { silent=true })

nmap('j', 'gj')
nmap('k', 'gk')
nmap('<leader><leader>', '<c-^>')
nmap('<leader>tn', ':tabnext<CR>')

nmap('Q', '')
nmap('<F1>', '')
imap('<F1>', '')

nmap('<C-u>', '<C-u>zz')
nmap('<C-d>', '<C-d>zz')
nmap('<C-f>', '<C-f>zz')

nmap('<tab>', ':normal za<cr>', { noremap = true, silent = true })

nmap('<leader>tt', '<cmd>Trouble<cr>', { silent = true })
nmap('<leader>td', '<cmd>Trouble lsp_definitions<cr>', { silent = true })
nmap('<leader>tr', '<cmd>Trouble lsp_references<cr>', { silent = true })

nmap('<leader>gg', '<cmd>Neogit<cr>', { silent = true })
nmap('<leader>gb', '<cmd>Git blame<cr>', { silent = true })

nmap('<leader>bd', ':lua K["delete-hidden-bufs"]()<CR>', { silent = true })

vim.cmd "cabbrev W w"
vim.cmd "cabbrev Xa xa"

vim.cmd "command! -nargs=0 Format :lua vim.lsp.buf.formatting_sync()<cr>"
vim.cmd "command! Dnd :!dragon-drag-and-drop %"
