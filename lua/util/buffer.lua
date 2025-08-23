-- Buffer utilities for AstroNvim v5 compatibility
local M = {}

-- Get list of valid buffers
function M.get_valid_buffers()
  local bufs = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
      table.insert(bufs, buf)
    end
  end
  return bufs
end

-- Navigate to buffer by offset
function M.nav(offset)
  local bufs = M.get_valid_buffers()
  if #bufs <= 1 then return end
  
  local current = vim.api.nvim_get_current_buf()
  local idx = 1
  for i, buf in ipairs(bufs) do
    if buf == current then
      idx = i
      break
    end
  end
  
  local new_idx = ((idx + offset - 1) % #bufs) + 1
  vim.api.nvim_set_current_buf(bufs[new_idx])
end

-- Close buffer
function M.close(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local bufs = M.get_valid_buffers()
  
  if #bufs > 1 then
    -- Switch to another buffer before closing
    for _, buf in ipairs(bufs) do
      if buf ~= bufnr then
        vim.api.nvim_set_current_buf(buf)
        break
      end
    end
  end
  
  vim.api.nvim_buf_delete(bufnr, { force = false })
end

return M