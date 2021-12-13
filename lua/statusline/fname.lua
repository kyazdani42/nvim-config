local a = vim.api
local fn = vim.fn

local Constants = require'statusline.constants'
local groups = Constants.groups

local M = {}

local function normalize(s)
  return groups.fname..s
end

function M.get(bufnr)
  local fname = a.nvim_buf_get_name(bufnr)
  if #fname == 0 then
    return normalize('[NO NAME]'), 9, ''
  end

  local modified = ' '..fn.fnamemodify(fname, ':p:.')..' '
  return normalize(modified), #modified, fname
end

return M
