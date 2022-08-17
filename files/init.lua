local fn = vim.fn
local set = vim.opt
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

vim.g.mapleader = " "
vim.opt.number = true

local packer = require("packer")

packer.startup(function(use)
	use("neovim/nvim-lspconfig")
	use("nvim-treesitter/nvim-treesitter")
	use("nvim-lua/plenary.nvim")
	use("ray-x/go.nvim")
	use("simrat39/rust-tools.nvim")
	use("tjdevries/colorbuddy.nvim")
	use("bkegley/gloombuddy")
	use("jose-elias-alvarez/null-ls.nvim")
	use("nvim-lua/lsp-status.nvim")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/vim-vsnip")
	use("nvim-telescope/telescope.nvim")
	use("j-hui/fidget.nvim")
	use("itchyny/lightline.vim")
	use("folke/trouble.nvim")
	use("kyazdani42/nvim-web-devicons")
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
	use("leoluz/nvim-dap-go")
	use("theHamsta/nvim-dap-virtual-text")
	if packer_bootstrap then
		packer.sync()
	end
end)

require("trouble").setup({})

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end,
		})
	end
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	local opts = { noremap = true, silent = true }
	vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<space>f", vim.lsp.buf.formatting, bufopts)
	vim.keymap.set("n", "<F5>", ":lua require('dap').continue()<CR>")
	vim.keymap.set("n", "<F10>", ":lua require('dap').step_over()<CR>")
	vim.keymap.set("n", "<F11>", ":lua require('dap').step_into()<CR>")
	vim.keymap.set("n", "<F12>", ":lua require('dap').step_out()<CR>")
	vim.keymap.set("n", "<F9>", ":lua require('dap').toggle_breakpoint()<CR>")
	vim.keymap.set("n", "<leader>B", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
	vim.keymap.set(
		"n",
		"<leader>lp",
		":lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>"
	)
	vim.keymap.set("n", "<leader>dr", ":lua require('dap').repl.open()<CR>")
	vim.keymap.set("n", "<leader>dt", ":lua require('dap-go').debug_test()<CR>")
end

local lspconfig = require("lspconfig")

lspconfig.jedi_language_server.setup({ on_attach = on_attach })

lspconfig.sumneko_lua.setup({
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			format = { enable = false },
			telemetry = { enable = false },
		},
	},
	on_attach = on_attach,
})

lspconfig.gopls.setup({
	cmd = { "gopls", "serve" },
	settings = { gopls = { analyses = { unusedparams = true }, staticcheck = true } },
	on_attach = on_attach,
})

require("nvim-treesitter.configs").setup({
	ensure_installed = { "rust", "go", "c", "cpp" },
})

require("go").setup({ goimport = "gopls", gofmt = "gofmt" })

require("rust-tools").setup({
	server = {
		on_attach = on_attach,
		standalone = true,
		settings = {
			["rust-analyzer"] = {
				assist = { importPrefix = "by_self" },
				cargo = { allFeatures = true },
				checkOnSave = { command = "clippy" },
				lens = { references = true, methodReferences = true },
			},
		},
	},
})

require("colorbuddy").colorscheme("gloombuddy")

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.gofmt,
		null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.formatting.autopep8,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.clang_format,
		null_ls.builtins.diagnostics.flake8,
		null_ls.builtins.formatting.taplo,
	},
	on_attach = on_attach,
})

local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
	},

	sources = { { name = "nvim_lsp" }, { name = "vsnip" } },
})

local dap = require("dap")
dap.adapters.lldb = {
	type = "executable",
	command = "/usr/bin/lldb-vscode", -- adjust as needed, must be absolute path
	name = "lldb",
}

dap.configurations.cpp = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
	},
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

require("dap-go").setup()
require("dapui").setup()
require("nvim-dap-virtual-text").setup()
