local M = {}

local Constants = require'statusline.constants'
local groups = Constants.groups

local branch_by_name = {}

local function git_revparse(fname)
  local pwd = vim.fn.fnameescape(vim.fn.fnamemodify(fname, ':p:h'))
  return vim.fn.system('git -C '..pwd..' rev-parse --abbrev-ref HEAD'):sub(0, -2)
end

function M.get_branch(fname)
  local branch = branch_by_name[fname]
  if not branch then
    branch = git_revparse(fname)
    branch_by_name[fname] = branch
  end

  local is_git = branch:match('fatal') == nil
  if is_git then
    return groups.git..' '..branch..' ', #branch + 2
  end

  return '', 0
end

return M
