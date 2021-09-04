local actions = require('telescope.actions')

local function set_map(map, cmd_name)
  return vim.api.nvim_set_keymap('n', map, "<cmd>lua require('telescope.builtin')."..cmd_name.."()<cr>", {
    noremap = true, silent = true
  })
end

set_map('<C-p>', 'find_files')
set_map('<C-b>', 'buffers')
set_map('<C-t>', 'live_grep')

local ivy =  {
  theme = "ivy",
  borderchars = {
    preview = {"─", "│", "─", "│", "┌", "┐", "┘", "└"}
  }
}

require('telescope').setup{
  defaults = {

    prompt_prefix = " ",
    layout_config = {
      height = 15,
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  },
  pickers = {
    buffers = ivy,
    find_files = ivy,
    live_grep = ivy,
  }
}

-- need to schedul
vim.schedule(function()
  vim.cmd [[
  highlight TelescopeSelectionCaret guifg=#89ddff gui=bold
  highlight TelescopePromptPrefix   guifg=#89ddff gui=bold
  highlight TelescopeSelection      guifg=#ffffff gui=bold
  highlight TelescopeMultiSelection guifg=#b9a3eb
  highlight TelescopePromptBorder   guifg=#1b1e2b
  highlight TelescopeBorder         guifg=#32374d
  highlight TelescopePreviewBorder  guifg=#32374d
  highlight TelescopeResultsBorder  guifg=#444267
  highlight TelescopeMatching       guifg=#ffcb6b
  ]]
end)
