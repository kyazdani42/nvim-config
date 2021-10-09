vim.g.nvim_tree_ignore = { '.git', 'node_modules', 'dist' }
vim.g.nvim_tree_gitignore = 1
vim.g.nvim_tree_show_icons = {
	git = 1,
	folders = 1,
	files = 1,
  folder_arrows = 1
}
vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_window_picker_exclude = {
  filetype = {
    "packer",
    "qf",
    "Trouble"
  }
}

vim.g.nvim_tree_icons = {
	default = '',
	git = {
		unstaged = "✗",
		staged = "✓",
		unmerged = "",
		renamed = "➜",
		untracked = "★"
	},
	folder = {
		default = "",
		open = ""
	}
}

vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', {
	noremap = true,
	silent = true
})

vim.api.nvim_set_keymap('n', '<leader>r', ':NvimTreeRefresh<CR>', {
	noremap = true,
	silent = true
})

require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = true,
  open_on_tab         = true,
  update_to_buf_dir   = {
    enable = true,
    auto_open = true,
  },
  lsp_diagnostics     = true,
  auto_close          = false,
  hijack_cursor       = true,
  update_cwd          = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = { 'fzf', 'help', 'git' }
  },
  ignore_ft_on_setup = { 'git', 'man', 'help' },
  system_open = {
    cmd  = nil,
    args = {}
  },
  view = {
    width = 35,
    side = 'left',
    auto_resize = true,
    mappings = {
      custom_only = false,
      list = {
        { mode = "n", key = "<C-t>", cb = "<cmd>lua require'telescope.builtin'.live_grep()<cr>" }
      }
    }
  }
}
