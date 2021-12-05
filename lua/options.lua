local opt = vim.opt

-- opt.debug = 'throw'
opt.updatetime = 300
opt.foldlevelstart = 99
opt.termguicolors = true
opt.mouse= 'a' -- Enable mouse
opt.ignorecase = true -- Ignore case
opt.confirm = true -- Disable 'no write'
opt.scrolloff = 8 -- Lines from the cursor
opt.incsearch = true -- Move cursor during search
opt.splitright = true -- Splits open on the right
opt.splitbelow = true -- Splits open on the bottom
opt.wildmenu = true -- Command line completion mode
opt.wildmode = 'full' -- Command line completion mode
opt.hlsearch = true -- Highlight search results (enforce)
opt.showmatch = true -- Show matching brackets/parenthesis
opt.showmode = false -- Do not output message on the bottom
opt.inccommand = 'split' -- Show effects of command as you type in a split
opt.clipboard = 'unnamedplus' -- Use system clipboard
opt.shortmess:append "c"
opt.completeopt = { "menu", "menuone", "noselect" }
opt.guifont = 'monospace:h15'
opt.wrap = false
opt.relativenumber = true
opt.cursorline = true
opt.linebreak = true
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'
opt.signcolumn = 'yes'
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true
-- avoid autocommenting on newline.
-- needs autocmd because option is local to buffer.
vim.cmd "au BufEnter * setlocal formatoptions-=cro"
