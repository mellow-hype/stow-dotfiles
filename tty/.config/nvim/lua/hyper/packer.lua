-- install packer if it isn't already
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- colorschemes
  use 'sainnhe/gruvbox-material'
  use 'morhetz/gruvbox'

  -- core plugins
  use 'preservim/vim-markdown'
  use 'preservim/nerdtree'
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'

  -- dev plugins
  use 'dense-analysis/ale'
  -- use 'neovim/nvim-lspconfig'

  -- plugins that only work on neovim versions above 0.7
  if vim.v.version >= 700 then
      -- telescope fuzzy finder/file manager
      use {
          'nvim-telescope/telescope.nvim', tag = '0.1.4',
          requires = { {'nvim-lua/plenary.nvim'} }
      }
      use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  end


  -- this needs to come at the end of all other packages
  if packer_bootstrap then
      require('packer').sync()
  end
end)
