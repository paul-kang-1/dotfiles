-- bootstrapping
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	-- Visuals
	use { 'andymass/vim-matchup', event = 'VimEnter' }
	use 'rebelot/kanagawa.nvim'
	use { "catppuccin/nvim", as = "catppuccin" }
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'nvim-tree/nvim-web-devicons', opt = true },
		config = function() require('lualine').setup() end
	}

	-- Convenience plugins
	-- use 'tpope/vim-vinegar'
	use 'tpope/vim-commentary'
	use 'jreybert/vimagit'

	use { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview' }

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.1',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}
	use {
		"windwp/nvim-autopairs",
		config = function() require("nvim-autopairs").setup {} end
	}
	use 'ntpeters/vim-better-whitespace'

	-- File explorer (netrw substitute)
	use {
		'stevearc/oil.nvim',
		config = function()
			require('oil').setup({
				columns = {
					"icon",
					"permissions",
					"size",
					"mtime",
				},
			})
		end
	}

	use 'nvim-tree/nvim-web-devicons'

	-- Terminal
	use 'voldikss/vim-floaterm'

	-- Syntax highlighting & LSP
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
			-- LSP Support
			{ 'neovim/nvim-lspconfig' }, -- Required
			{
			                  -- Optional
				'williamboman/mason.nvim',
				run = function()
					pcall(vim.cmd, 'MasonUpdate')
				end,
			},
			{ 'williamboman/mason-lspconfig.nvim' }, -- Optional

			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' }, -- Required
			{ 'hrsh7th/cmp-nvim-lsp' }, -- Required
			{ 'hrsh7th/cmp-buffer' }, -- Optional
			{ 'hrsh7th/cmp-path' }, -- Optional
			{ 'saadparwaiz1/cmp_luasnip' }, -- Optional
			{ 'hrsh7th/cmp-nvim-lua' }, -- Optional

			-- Snippets
			{ 'L3MON4D3/LuaSnip' }, -- Required
			{ 'rafamadriz/friendly-snippets' }, -- Optional
		}
	}
	
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end)
