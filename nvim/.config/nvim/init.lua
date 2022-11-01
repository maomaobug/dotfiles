-- init.lua

require('impatient')

-- Options
-- Settings
local opt = vim.opt
local cmd = vim.cmd

opt.textwidth = 100
opt.scrolloff = 7
opt.wildignore = { '*.o', '*~', '*.pyc' }
opt.wildmode = 'longest,full'
opt.whichwrap:append '<,>,h,l'
opt.inccommand = 'nosplit'
opt.lazyredraw = true
opt.showmatch = true
opt.ignorecase = true
opt.smartcase = true
opt.tabstop = 2
opt.softtabstop = 0
opt.expandtab = true
opt.shiftwidth = 2
opt.number = true
opt.relativenumber = true
opt.smartindent = true
opt.laststatus = 3
-- opt.showmode = false
opt.shada = [['20,<50,s10,h,/100]]
opt.hidden = true
opt.shortmess:append 'c'
opt.joinspaces = false
opt.guicursor = [[n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50]]
opt.updatetime = 100
opt.conceallevel = 2
opt.concealcursor = 'nc'
opt.previewheight = 5
opt.undofile = true
opt.synmaxcol = 500
opt.display = 'msgsep'
opt.cursorline = true
opt.modeline = false
opt.mouse = 'nivh'
opt.signcolumn = 'yes:1'
-- Colorscheme
opt.termguicolors = true
opt.background = 'light'
-- cmd [[colorscheme gruvbox-material]]
cmd [[colorscheme everforest]]
-- netrw tree style
vim.g.netrw_liststyle = 3

local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

require('settings.cmds').setup()
require('settings.keymaps').setup_global()
require('settings.keymaps').setup_dap()
require('settings.diag')
require('settings.lsp')

local autoreadonly = vim.api.nvim_create_augroup("autoreadonly", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead" }, {
  group = autoreadonly,
  pattern = {
    vim.env.HOME.."/go/*",
    "/opt/homebrew/Cellar/go/*"
  },
  callback = function(arg)
    vim.bo.modifiable = false
  end
})
