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

require('packer').reset()
require('packer').init({
  compile_path = vim.fn.stdpath('data')..'/site/plugin/packer_compiled.lua',
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'solid' })
    end,
  },
})

local use = require('packer').use

-- Packer can manage itself.
use('wbthomason/packer.nvim')

-- Theme
use "folke/tokyonight.nvim"

-- Commenting support.
use('tpope/vim-commentary')

-- Add, change, and delete surrounding text.
use('tpope/vim-surround')

-- Useful commands like :Rename and :SudoWrite.
use('tpope/vim-eunuch')

-- Indent autodetection with editorconfig support.
use('tpope/vim-sleuth')

-- Allow plugins to enable repeating of commands.
use('tpope/vim-repeat')

-- Add more languages.
use('sheerun/vim-polyglot')

-- Navigate seamlessly between Vim windows and Tmux panes.
use('christoomey/vim-tmux-navigator')

-- Jump to the last location when opening a file.
use('farmergreg/vim-lastplace')

-- Enable * searching with visually selected text.
use('nelstrom/vim-visual-star-search')

-- Automatically create parent dirs when saving.
use('jessarcher/vim-heritage')

-- Text objects for HTML attributes.
use({
  'whatyouhide/vim-textobj-xmlattr',
  requires = 'kana/vim-textobj-user',
})

-- Automatically set the working directory to the project root.
use({
  'airblade/vim-rooter',
  setup = function()
    -- Instead of this running every time we open a file, we'll just run it once when Vim starts.
    vim.g.rooter_manual_only = 1
  end,
  config = function()
    vim.cmd('Rooter')
  end,
})

-- Automatically add closing brackets, quotes, etc.
use({
  'windwp/nvim-autopairs',
  config = function()
    require('nvim-autopairs').setup()
  end,
})

-- Add smooth scrolling to avoid jarring jumps
use({
  'karb94/neoscroll.nvim',
  config = function()
    require('neoscroll').setup()
  end,
})

-- All closing buffers without closing the split window.
use({
  'famiu/bufdelete.nvim',
  config = function()
    vim.keymap.set('n', '<Leader>q', ':Bdelete<CR>')
  end,
})

-- Split arrays and methods onto multiple lines, or join them back up.
use({
  'AndrewRadev/splitjoin.vim',
  config = function()
    vim.g.splitjoin_html_attributes_bracket_on_new_line = 1
    vim.g.splitjoin_trailing_comma = 1
    vim.g.splitjoin_php_method_chain_full = 1
  end,
})

-- Automatically fix indentation when pasting code.
use({
  'sickill/vim-pasta',
  config = function()
    vim.g.pasta_disabled_filetypes = { 'fugitive' }
  end,
})

-- Fuzzy finder
use({
  'nvim-telescope/telescope.nvim',
  requires = {
    'nvim-lua/plenary.nvim',
    'kyazdani42/nvim-web-devicons',
    'nvim-telescope/telescope-live-grep-args.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
  },
  config = function()
    require('user/plugins/telescope')
  end,
})

-- File tree sidebar
use({
  'kyazdani42/nvim-tree.lua',
  requires = 'kyazdani42/nvim-web-devicons',
  config = function()
    require('user/plugins/nvim-tree')
  end,
})

-- Lualine
use ({
  'nvim-lualine/lualine.nvim',
  requires = 'kyazdani42/nvim-web-devicons',
  config = function ()
    require('user/plugins/lualine')
  end,
})

-- Bufferline
use({
  'akinsho/bufferline.nvim',
  requires = 'kyazdani42/nvim-web-devicons',
  after = 'tokyonight.nvim',
  config = function()
    require('bufferline').setup({
    options = {
      indicator = {
        icon = ' ',
      },
      show_close_icon = false,
      tab_size = 0,
      max_name_length = 25,
      offsets = {
        {
          filetype = 'NvimTree',
          text = '  Files',
          highlight = 'StatusLine',
          text_align = 'left',
        },
      },
      separator_style = 'slant',
      modified_icon = '',
      custom_areas = {
        left = function()
          return {
            { text = '    ', fg = '#8fff6d' },
          }
        end,
      },
    },
    highlights = {
      fill = {
        bg = { attribute = 'bg', highlight = 'StatusLine' },
      },
      background = {
        bg = { attribute = 'bg', highlight = 'StatusLine' },
      },
      tab = {
        bg = { attribute = 'bg', highlight = 'StatusLine' },
      },
      tab_close = {
        bg = { attribute = 'bg', highlight = 'StatusLine' },
      },
      close_button = {
        bg = { attribute = 'bg', highlight = 'StatusLine' },
        fg = { attribute = 'fg', highlight = 'StatusLineNonText' },
      },
      close_button_visible = {
        bg = { attribute = 'bg', highlight = 'StatusLine' },
        fg = { attribute = 'fg', highlight = 'StatusLineNonText' },
      },
      close_button_selected = {
        fg = { attribute = 'fg', highlight = 'StatusLineNonText' },
      },
      buffer_visible = {
        bg = { attribute = 'bg', highlight = 'StatusLine' },
      },
      modified = {
        bg = { attribute = 'bg', highlight = 'StatusLine' },
      },
      modified_visible = {
        bg = { attribute = 'bg', highlight = 'StatusLine' },
      },
      duplicate = {
        bg = { attribute = 'bg', highlight = 'StatusLine' },
      },
      duplicate_visible = {
        bg = { attribute = 'bg', highlight = 'StatusLine' },
      },
      separator = {
        fg = { attribute = 'bg', highlight = 'StatusLine' },
        bg = { attribute = 'bg', highlight = 'StatusLine' },
      },
      separator_selected = {
        fg = { attribute = 'bg', highlight = 'StatusLine' },
        bg = { attribute = 'bg', highlight = 'Normal' }
      },
      separator_visible = {
        fg = { attribute = 'bg', highlight = 'StatusLine' },
        bg = { attribute = 'bg', highlight = 'StatusLine' },
      },
    },
  })
  end,
})

-- Indent Blankline
use({
  'lukas-reineke/indent-blankline.nvim',
  filetype_exclude = {
    'help',
    'terminal',
    'dashboard',
    'packer',
    'lspinfo',
    'TelescopePrompt',
    'TelescopeResults',
  },
  buftype_exclude = {
    'terminal',
    'NvimTree',
  },
  config = function()
    require("ibl").setup()
  end,
})

-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
if packer_bootstrap then
    require('packer').sync()
end

-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
if packer_bootstrap then
    require('packer').sync()
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile>
  augroup end
]])
