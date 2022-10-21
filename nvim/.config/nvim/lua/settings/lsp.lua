-- capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lsp_status = require('lsp-status')
capabilities = vim.tbl_extend('keep', capabilities or {}, lsp_status.capabilities)

lsp_status.register_progress()

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local function on_attach(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  require('settings.keymaps').lsp_attached_only(client, bufnr)
  lsp_status.on_attach(client)
end

local servers_using_default_conf = {
  'bashls', -- https://github.com/mads-hartmann/bash-language-server
  'gopls', -- Gopls: https://github.com/golang/tools/blob/master/gopls/doc/vim.md
  'graphql', -- Graphql: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#graphql
  'tsserver', -- https://github.com/theia-ide/typescript-language-server
}
local lspconfig = require('lspconfig')
for _, s in ipairs(servers_using_default_conf) do
  lspconfig[s].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Lua
lspconfig.sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
