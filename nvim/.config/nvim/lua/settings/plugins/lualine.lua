local M = {}

function M.setup()
  require('lualine').setup {
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = {'filename'},
      lualine_x = {"require('lsp-status').status()"},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    }
  }
end

return M
