return {
	{
		-- Config for nvim's builtin LSP; the main plugin for LSP
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			-- Manage language servers, linters, etc.
			"williamboman/mason.nvim",
			-- Bridges mason with nvim-lspconfig to ensure seamless installation and config of LSP servers
			"williamboman/mason-lspconfig.nvim",
			-- Install or upgrade all your third-party tools
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			-- Autoformatting
			"stevearc/conform.nvim",
			-- small bottom-right-corner UI displaying progress updates for background tasks
			{ "j-hui/fidget.nvim", opts = {} },
			-- UI rendering diagnostics messages directly on top of the affected lines of code
			{ "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },
			-- Schemas for various config files from various tools/frameworks to ensure coding of necessary properties isn't missed;
			-- makes life easier by preempting bugs arising from forgetting to define specific properties
			-- supports common formats like JSON/YAML/TOML/XML/INI and other uncommon formats
			"b0o/SchemaStore.nvim",
		},
		config = function()
			local capabilities = nil -- Without cmp_nvim_lsp, default LSP capabilities is nil
			if pcall(require, "cmp_nvim_lsp") then
				capabilities = require("cmp_nvim_lsp").default_capabilities()
			end

			local lspconfig = require("lspconfig") -- Add additional capabilities supported by nvim-cmp

			local servers = {
				-- LaTeX LSP
				texlab = true,
				-- bash LSP
				bashls = true,
				-- lua LSP
				lua_ls = {
					server_capabilities = {
						semanticTokensProvider = vim.NIL,
					},
				},
				-- Markdown LSP
				marksman = true,
				-- Python LSP (no formatting)
				pyright = true,
				-- css LSP
				cssls = true,
				-- templ LSP (no formatting/linting)
				templ = true,
				-- TOML LSP (no linting)
				taplo = true,
				-- JSON LSP
				jsonls = {
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				},
				-- YAML LSP
				yamlls = {
					settings = {
						schemastore = {
							enable = false,
							url = "",
						},
					},
				},
				-- Typescript/JS LSP (no linting)
				tsserver = {
					server_capabilities = {
						documentFormattingProvider = false,
					},
				},
				-- C/C++ LSP (only basic linting)
				clangd = {
					init_options = { clangdFileStatus = true },
					filetypes = { "c" },
				},
			}

			-- a list of servers that doesn't require manual installation; currently there are none
			local servers_to_install = vim.tbl_filter(function(key)
				local t = servers[key]
				if type(t) == "table" then
					return not t.manual_install
				else
					return t
				end
			end, vim.tbl_keys(servers))

			require("mason").setup()
			local ensure_installed = {
				-- bash LSP
				"bashls",
				-- lua LSP
				"lua_ls",
				-- lua formatter
				"stylua",
			}

			vim.list_extend(ensure_installed, servers_to_install)
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			-- merge default LSP capabilities with server configs
			for name, config in pairs(servers) do
				if config == true then
					config = {}
				end
				config = vim.tbl_deep_extend("force", {}, {
					capabilities = capabilities,
				}, config)

				lspconfig[name].setup(config)
			end

			-- filetypes specified for disabling of semantic tokens
			local disable_semantic_tokens = {
				lua = true,
			}

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

					-- ensures LSP settings for a buffer is always a table to prevent nil errors
					local settings = servers[client.name]
					if type(settings) ~= "table" then
						settings = {}
					end

					-- disables semantic tokens for filetypes specified earlier
					local filetype = vim.bo[bufnr].filetype
					if disable_semantic_tokens[filetype] then
						client.server_capabilities.semanticTokensProvider = nil
					end

					--Override server capabilities
					if settings.server_capabilities then
						for k, v in pairs(settings.server_capabilities) do
							if v == vim.NIL then
								---@diagnostic disable-next-line: cast-local-type
								v = nil
							end

							client.server_capabilities[k] = v
						end
					end
				end,
			})

			require("conform").setup({
				formatters_by_ft = {
					-- use stylua for lua formatting over lua_ls
					lua = { "stylua" },
				},
			})

			-- autocommand to format buffer before saving
			vim.api.nvim_create_autocmd("BufWritePre", {
				callback = function(args)
					require("conform").format({
						bufnr = args.buf,
						lsp_fallback = true,
						quiet = true,
					})
				end,
			})

			-- configure lsp_lines to use virtual text instead of virtual lines
			require("lsp_lines").setup()
			vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
		end,
	},
}
