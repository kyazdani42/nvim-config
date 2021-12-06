local a = vim.api

local M = {}

function M.delete_hidden_bufs()
  for _, buf in pairs(a.nvim_list_bufs()) do
    local bufinfo = vim.fn.getbufinfo(buf)[1]
    if bufinfo.hidden == 1 then
      a.nvim_buf_delete(buf, { force = true })
    end
  end
end

return M
