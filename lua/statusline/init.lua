local a = vim.api

local M = {}

local Filename = require'statusline.fname'
local Git = require'statusline.git'
local Constants = require'statusline.constants'
local groups = Constants.groups

local function get_mode()
  local m = a.nvim_get_mode().mode
  local mode = Constants.modes[m] or { val = '!! UNKNOWN MODE !! '..m, color = groups.cursorline }
  return mode.color..mode.val, #mode.val, mode.color
end

local function get_infos(bufnr, mode_color)
  local ft = a.nvim_buf_get_option(bufnr, 'ft')
  if ft ~= '' then
    ft = ' '..ft..' |'
  end

  local _, row, col = unpack(vim.fn.getpos('.'))
  local num_lines = #a.nvim_buf_get_lines(bufnr, 0, -1, false)
  local percent = string.format('%d', row / num_lines * 100) .. '%%'

  local formatted = string.format('%s %s:%s | %s | %s', ft, row, col, percent, num_lines)
  return mode_color:gsub('MD', 'Info')..formatted, #formatted
end

local function format_status(content)
  local left_side = content.mode.value..content.filename.value
  local right_side = content.git.value..content.infos.value
  local total_size = a.nvim_win_get_width(0)

  local size_right = content.mode.size + content.filename.size + content.git.size + content.infos.size
  local padding = string.rep(' ', total_size - size_right)

  return '%#NormalFloat#'..left_side..'%#NormalFloat#'..padding..right_side
end

function M.update()
  local bufnr = a.nvim_get_current_buf()
  if a.nvim_buf_get_option(bufnr, 'ft') == 'NvimTree' then return ' ' end

  local mode, mode_size, mode_color = get_mode()
  local filename, filename_size, fullname = Filename.get(bufnr)
  local git, git_size = Git.get_branch(fullname)
  local infos, infos_size = get_infos(bufnr, mode_color)

  local formatted_status = format_status {
    mode = { value = mode, size = mode_size, color = mode_color },
    filename = { value = filename, size = filename_size },
    git = { value = git, size = git_size },
    infos = { value = infos, size = infos_size }
  }

  return formatted_status
end

function M.clear()
  local width = a.nvim_win_get_width(0)
  local dashes = string.rep('―', width)
  vim.opt_local.statusline = groups.vertsplit..dashes
end

function M.update_colorscheme()
  for name, c in pairs(Constants.get_colors()) do
    local cmd = 'hi! def '..name..' '
    if c.gui then
      cmd = cmd .. 'gui='..c.gui..' '
    end
    if c.guifg then
      cmd = cmd .. 'guifg='..c.guifg..' '
    end
    if c.guibg then
      cmd = cmd .. 'guibg='..c.guibg..' '
    end

    vim.cmd(cmd)
  end
end

function M.setup()
  M.update_colorscheme()
  vim.cmd [[
  function! Status()
  return luaeval("require 'statusline'.update()")
  endfunction
  ]]

  vim.cmd [[
  augroup StatusLine
  au!
  au TabEnter,WinLeave,BufEnter,WinEnter,VimEnter * lua require'statusline'.clear()
  au BufEnter,VimEnter * setlocal statusline=%!Status()
  au Colorscheme * lua require'statusline'.update_colorscheme()
  augroup END
  ]]
end

return M
