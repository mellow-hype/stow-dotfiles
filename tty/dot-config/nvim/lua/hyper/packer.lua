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

  --- core plugins
  -- use 'preservim/nerdtree'
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'tpope/vim-eunuch'
  use "folke/which-key.nvim"
  use 'ojroques/nvim-bufdel' -- smarter bufdelete

  --- picker
  use "ibhagwan/fzf-lua"

  --- colorschemes + looks
  -- use 'sainnhe/gruvbox-material'
  -- use 'morhetz/gruvbox'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'nvimdev/dashboard-nvim'

  -- autocomplete
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-omni'
  use 'hrsh7th/nvim-cmp'

  -- dev plugins
  use 'neovim/nvim-lspconfig'
  use 'nvim-treesitter/nvim-treesitter'

  -- filetype support
  use { 'preservim/vim-markdown', ft = {"markdown"} }

  -- this needs to come at the end of all other packages
  if packer_bootstrap then
      require('packer').sync()
  end
end)
