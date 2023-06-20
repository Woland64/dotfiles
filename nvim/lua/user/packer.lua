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
  use 'wbthomason/packer.nvim'
  -- My plugins here
  -- use 'foo1/bar1.nvim'
  -- use 'foo2/bar2.nvim'
  use 'Mofiqul/dracula.nvim'
  vim.cmd[[colorscheme dracula]]

  use 'preservim/nerdtree'
  vim.keymap.set('n', '<Leader>nn', '<cmd>NERDTreeToggle<cr>')
  vim.keymap.set('n', '<Leader>nf', '<cmd>NERDTreeFind<cr>')
  vim.g.NERDTreeWinPos = 'right'

  use 'tpope/vim-fugitive'

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  use {
      'nvim-telescope/telescope.nvim', tag = '0.1.1',
      requires = { {'nvim-lua/plenary.nvim'} }
  }
  local builtin = require('telescope.builtin')
  vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
  vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
  vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

  use { 'lewis6991/gitsigns.nvim', config = function() require('gitsigns').setup() end }

  use {
      'nvim-lualine/lualine.nvim',
      requires = { 'nvim-tree/nvim-web-devicons', opt = false }
  }

  use 'mileszs/ack.vim'
  vim.keymap.set('n', '<Leader>g', ':Ack! ')

  use 'm4xshen/autoclose.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
      require('packer').sync()
  end
end)
