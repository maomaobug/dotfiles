local packer = nil
local function init()
  if packer == nil then
    packer = require 'packer'
    packer.init {
      compile_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer_compiled/plugin/packer_compiled.lua',
      disable_commands = true,
      display = {
        open_fn = function()
          local result, win, buf = require('packer.util').float {
            border = {
              { '╭', 'FloatBorder' },
              { '─', 'FloatBorder' },
              { '╮', 'FloatBorder' },
              { '│', 'FloatBorder' },
              { '╯', 'FloatBorder' },
              { '─', 'FloatBorder' },
              { '╰', 'FloatBorder' },
              { '│', 'FloatBorder' },
            },
          }
          vim.api.nvim_win_set_option(win, 'winhighlight', 'NormalFloat:Normal')
          return result, win, buf
        end,
      },
    }
  end

  local use = packer.use
  packer.reset()

  -- Packer
  use { 'wbthomason/packer.nvim', opt = true }
  use 'lewis6991/impatient.nvim'
  -- Colorscheme
  use 'sainnhe/gruvbox-material'
  use 'sainnhe/everforest'
  -- Treesitter
  use {'nvim-treesitter/nvim-treesitter', run = function() vim.cmd [[TSUpdate]] end}
  -- LSP
  use 'neovim/nvim-lspconfig'
  use { 'nvim-lua/lsp-status.nvim', config = function() require('settings.plugins.lsp_status').setup() end }
  use { 'mfussenegger/nvim-lint', config = function() require('settings.plugins.lint').setup() end }
  -- Completion
  use {
    {
      'L3MON4D3/LuaSnip',
      event = 'InsertEnter',
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
      end,
    },
    'rafamadriz/friendly-snippets',
  }
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      { 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
    },
    config = function() require('settings.plugins.cmp').setup() end,
    event = 'InsertEnter',
    after = 'LuaSnip',
  }

  -- Code analysis
  use {
    'simrat39/symbols-outline.nvim',
    config = function() require('symbols-outline').setup() end,
  }

  -- Code editing
  use { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end }
  use { "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup {} end }
  -- Appearance
  use { 'lukas-reineke/indent-blankline.nvim',
    config = function()
      vim.g.indent_blankline_context_char = '┃'
      require('indent_blankline').setup {
        -- for example, context is off by default, use this to turn it on
        show_current_context = true,
      }
    end
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() require('settings.plugins.lualine').setup() end,
  }

  -- Debug
  use 'jbyuki/one-small-step-for-vimkind'
  use 'mfussenegger/nvim-dap'

  -- VCS
  use 'tpope/vim-fugitive'

  -- Filetype specific
  use {
    "iamcco/markdown-preview.nvim",
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" }
  }

  use 'buoto/gotests-vim'
end

local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end,
})

return plugins
