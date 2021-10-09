local Tools = {}

local patterns = {
  tsx = function(cname)
    return [[import React from 'react';

      interface ]]..cname..[[Props {
      }

      export const ]]..cname..[[: React.FC<]]..cname..[[Props> = () => {
      return (
      <div></div>
      )
      };
    ]]
  end,
  jsx = function(cname)
    return [[import React from 'react';

      export const ]]..cname..[[ = () => {
      return (
      <div></div>
      )
      }
    ]]
  end
}

function Tools.NewComponent(comp_name)
  local ft = vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), 'ft')
  if ft == "javascript" or ft == "javascriptreact" then
    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(patterns.jsx(comp_name), '\n'))
  elseif ft == "typescriptreact" then
    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(patterns.tsx(comp_name), '\n'))
  else
    return
  end
  vim.cmd"Format"
end

vim.cmd "command! -nargs=1 NewComponent :lua require'new-component'.NewComponent(<f-args>)<CR>"

return Tools
