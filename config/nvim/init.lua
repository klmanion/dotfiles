---- init.lua
-- created by: Kurt L. Manion
-- on: 31 May 2022

vim.opt.hidden = true

vim.opt.wildmenu = true

vim.opt.showcmd = true

vim.opt.hlsearch = false

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.backspace = 'indent,eol,start'

vim.opt.startofline = false

--- folding {{{1
--

vim.opt.foldenable = true

vim.opt.foldmethod = 'marker'
vim.opt.foldopen = 'block,hor,insert,jump,mark,percent,quickfix,search,tag,undo'
vim.opt.foldlevelstart = 1

vim.opt.foldcolumn = '3'

--- status line {{{1
--

vim.opt.ruler = false
vim.opt.laststatus = 2
vim.opt.statusline =		'%<%f\\ %m'
vim.opt.statusline:append	'%='	-- left-right divider
vim.opt.statusline:append	'%y\\ %l:%c%V\\ --\\ %p%%'

--- syntax {{{1
--

vim.cmd('filetype indent plugin on')

vim.opt.syntax = 'on'

vim.opt.number = true

vim.opt.ts = 8
vim.opt.sw = 8
vim.opt.expandtab = false
vim.opt.tw = 79

vim.opt.lispwords:append 'define/contract,λ'

vim.cmd[[
augroup haskell
	autocmd!
	au BufRead,BufNewFile *.hs set syntax=haskell filetype=haskell
	au FileType haskell set expandtab
augroup END
]]

--- color {{{1
--
vim.cmd 'let $NVIM_TUI_ENABLE_TRUE_COLOR=1'

vim.opt.termguicolors = true
vim.opt.background = 'dark'


-- local function kmap(mode, keys, com)
-- 	vim.api.nvim_set_keymap(mode, keys, com, { noremap = true, silent = true })
-- end

-- bootstrap packer
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	packer_bootstrap = true
	vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
	vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
	vim.cmd 'packadd packer.nvim'
end

-- plugins
-- run PackerInstall
require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'	-- must remain for packer to not remove itself

--	use 'neovim/nvim-lspconfig'
--	use 'glepnir/lspsaga.nvim'
--	use 'williamboman/nvim-lsp-installer'

	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

	use 'morhetz/gruvbox'

	use 'vim-syntastic/syntastic'
--	use { 'neoclide/coc.nvim', branch = 'release' }
	use 'dense-analysis/ale'

	use 'neovimhaskell/haskell-vim'
	use 'alx741/vim-hindent'

	if packer_bootstrap then
		require('packer').sync()
	end
end)

--- syntastic
vim.g.syntastic_always_populate_loc_list = 1
vim.g.syntastic_auto_loc_list = 1
vim.g.syntastic_check_on_open = 1
vim.g.syntastic_check_on_wq = 0

--- ale
--vim.g.ale_lint_on_enter = 0

--- colorscheme
vim.g.gruvbox_contrast_dark = [['hard']]
vim.cmd('colorscheme gruvbox')

require'nvim-treesitter.configs'.setup {
	ensure_installed = { "c", "haskell", "scheme", "latex", "bash", "lua", "rust" },

	highlight = {
		enable = true,

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
}

--require'nvim-lsp-installer'.setup ({
--	automatic_installation = true,
--})
--
--local saga = require 'lspsaga'
--saga.init_lsp_saga()
--
--local nvim_lsp = require('lspconfig')
--
---- Mappings.
---- See `:help vim.diagnostic.*` for documentation on any of the below functions
--local opts = { noremap=true, silent=true }
--vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
--vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
--vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
--vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
--
---- Use an on_attach function to only map the following keys
---- after the language server attaches to the current buffer
--local on_attach = function(client, bufnr)
--  -- Enable completion triggered by <c-x><c-o>
--  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
--
--  -- Mappings.
--  -- See `:help vim.lsp.*` for documentation on any of the below functions
--  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
--  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
--  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
--  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
--  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
--  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
--  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
----  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
--  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
--  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
--
--  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', ':Lspsaga code_action<CR>', opts)
--  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gh', '<cmd>Lspsaga lsp_finder<CR>', opts)
--end
--
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
--local servers = { 'rust_analyzer', 'hls', 'bashls', 'awk_ls', 'ltex', 'texlab',
--	'racket_langserver', 'sumneko_lua', }
--for _, lsp in pairs(servers) do
--  require('lspconfig')[lsp].setup {
--    on_attach = on_attach,
--  }
--end
--
--require'lspconfig'.sumneko_lua.setup {
--	settings = {
--		Lua = {
--			diagnostics = {
--				globals = { 'vim' }
--			}
--		}
--	}
--}

