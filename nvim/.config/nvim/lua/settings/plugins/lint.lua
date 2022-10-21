local M = {}

function M.setup()
  -- set linters by filetype
  require('lint').linters_by_ft = {
    go = {'golangcilint',}
  }

  -- autocommand
  local group = vim.api.nvim_create_augroup('nvim-lint', {clear = true})
  vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    group = group,
    callback = function()
      require('lint').try_lint()
    end,
  })
end

return M
