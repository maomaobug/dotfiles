---@diagnostic disable: need-check-nil
local M = {}

local symbol_kind_icons = {
  Array = '',
  Boolean = '',
  Class = '',
  Color = "",
  Component = '',
  Constant = '',
  Constructor = '',
  Enum = '',
  EnumMember = '',
  Event = '',
  Field = "",
  File = "",
  Folder = "",
  Fragment = '',
  Function = '',
  Interface = 'ﰮ',
  Key = '',
  Keyword = "",
  Method = '',
  Module = '',
  Namespace = '',
  -- Null = '',
  Null = '␀',
  Number = '#',
  Object = '⦿',
  Operator = '',
  Package = '',
  -- Property = '',
  Property = 'ﰠ',
  Reference = "",
  Snippet = "",
  -- String = '',
  String = '',
  Struct = '',
  Text = "",
  TypeParameter = '𝙏',
  Unit = "",
  Value = "",
  Variable = '',
}

function M.setup()
  local cmp = require('cmp')
  local luasnip = require('luasnip')
  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    }),
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'nvim_lsp_signature_help' },

    },
    formatting = {
      format = function(entry, vim_item)
        -- SymbolKind icons
        vim_item.kind = string.format('%s %s', symbol_kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
        -- Source
        vim_item.menu = ({
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          luasnip = "[LuaSnip]",
          nvim_lua = "[Lua]",
          latex_symbols = "[LaTeX]",
        })[entry.source.name]
        return vim_item
      end
    },
  }

  cmp.setup.cmdline(':', {
    sources = {
      { name = 'cmdline' }
    }
  })

  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
  )
end

return M
