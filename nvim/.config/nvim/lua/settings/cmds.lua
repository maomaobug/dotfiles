local M = {}

function M.setup()
  local cmd = vim.cmd
  local create_cmd = vim.api.nvim_create_user_command
  -- Packer
  create_cmd('PackerInstall', function()
    cmd [[packadd packer.nvim]]
    require('settings.plugins').install()
  end, {})
  create_cmd('PackerUpdate', function()
    cmd [[packadd packer.nvim]]
    require('settings.plugins').update()
  end, {})
  create_cmd('PackerSync', function()
    cmd [[packadd packer.nvim]]
    require('settings.plugins').sync()
  end, {})
  create_cmd('PackerClean', function()
    cmd [[packadd packer.nvim]]
    require('settings.plugins').clean()
  end, {})
  create_cmd('PackerCompile', function()
    cmd [[packadd packer.nvim]]
    require('settings.plugins').compile()
  end, {})
  create_cmd('PackerBootstrap', function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
      fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
      return true
    end
    return false
  end, {})
end

return M
