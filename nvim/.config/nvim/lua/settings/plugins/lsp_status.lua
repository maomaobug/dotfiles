local M = {}

function M.setup()
  require('lsp-status').config({
    diagnostics = false,
    kind_labels = {
      File = '',
      Module = '',
      Namespace = '',
      Package = '',
      Class = '',
      Method = '',
      -- Property = '',
      Property = 'ﰠ',
      Field = 'ﰠ',
      Constructor = '',
      Enum = '',
      Interface = 'ﰮ',
      Function = '',
      Variable = '',
      Constant = '',
      String = '',
      -- String = '',
      Number = '#',
      Boolean = '',
      Array = '',
      Object = '⦿',
      Key = '',
      -- Null = '',
      Null = '␀',
      EnumMember = '',
      Struct = '',
      Event = '',
      Operator = '',
      TypeParameter = '𝙏',
      Component = '',
      Fragment = '',
    },
    status_symbol = '',
  })
end

return M
