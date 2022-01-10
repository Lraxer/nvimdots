if not packer_plugins["nvim-lsp-installer"].loaded then
    vim.cmd [[packadd nvim-lsp-installer]]
end

if not packer_plugins["lsp_signature.nvim"].loaded then
    vim.cmd [[packadd lsp_signature.nvim]]
end

if not packer_plugins["lspsaga.nvim"].loaded then
    vim.cmd [[packadd lspsaga.nvim]]
end

local nvim_lsp = require("lspconfig")
local lsp_installer = require("nvim-lsp-installer")

lsp_installer.settings {
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
}

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.documentationFormat = {
    "markdown", "plaintext"
}
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport =
    true
capabilities.textDocument.completion.completionItem.tagSupport = {
    valueSet = {1}
}
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {"documentation", "detail", "additionalTextEdits"}
}

local function custom_attach()
    require("lsp_signature").on_attach({
        bind = true,
        use_lspsaga = false,
        floating_window = true,
        fix_pos = true,
        hint_enable = true,
        hi_parameter = "Search",
        handler_opts = {"double"}
    })
end

local function switch_source_header_splitcmd(bufnr, splitcmd)
    bufnr = nvim_lsp.util.validate_bufnr(bufnr)
    local params = {uri = vim.uri_from_bufnr(bufnr)}
    vim.lsp.buf_request(bufnr, "textDocument/switchSourceHeader", params,
                        function(err, result)
        if err then error(tostring(err)) end
        if not result then
            print("Corresponding file can’t be determined")
            return
        end
        vim.api.nvim_command(splitcmd .. " " .. vim.uri_to_fname(result))
    end)
end

local enhance_server_opts = {
    ["sumneko_lua"] = function(opts)
        opts.settings = {
            Lua = {
                diagnostics = {globals = {"vim", "packer_plugins"}},
                workspace = {
                    library = {
                        [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                        [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true
                    },
                    maxPreload = 100000,
                    preloadFileSize = 10000
                },
                telemetry = {enable = false}
            }
        }
    end,
    ["clangd"] = function(opts)
        opts.args = {
            "--background-index", "-std=c++20", "--pch-storage=memory",
            "--clang-tidy", "--suggest-missing-includes"
        }
        opts.single_file_support = true
        opts.commands = {
            ClangdSwitchSourceHeader = {
                function()
                    switch_source_header_splitcmd(0, "edit")
                end,
                description = "Open source/header in current buffer"
            },
            ClangdSwitchSourceHeaderVSplit = {
                function()
                    switch_source_header_splitcmd(0, "vsplit")
                end,
                description = "Open source/header in a new vsplit"
            },
            ClangdSwitchSourceHeaderSplit = {
                function()
                    switch_source_header_splitcmd(0, "split")
                end,
                description = "Open source/header in a new split"
            }
        }
    end,
    ["jsonls"] = function(opts)
        opts.cmd = {"json-languageserver", "--stdio"}
        opts.settings = {
            json = {
                -- Schemas https://www.schemastore.org
                schemas = {
                    {
                        fileMatch = {"package.json"},
                        url = "https://json.schemastore.org/package.json"
                    }, {
                        fileMatch = {"tsconfig*.json"},
                        url = "https://json.schemastore.org/tsconfig.json"
                    }, {
                        fileMatch = {
                            ".prettierrc", ".prettierrc.json",
                            "prettier.config.json"
                        },
                        url = "https://json.schemastore.org/prettierrc.json"
                    }, {
                        fileMatch = {".eslintrc", ".eslintrc.json"},
                        url = "https://json.schemastore.org/eslintrc.json"
                    }, {
                        fileMatch = {
                            ".babelrc", ".babelrc.json", "babel.config.json"
                        },
                        url = "https://json.schemastore.org/babelrc.json"
                    },
                    {
                        fileMatch = {"lerna.json"},
                        url = "https://json.schemastore.org/lerna.json"
                    }, {
                        fileMatch = {
                            ".stylelintrc", ".stylelintrc.json",
                            "stylelint.config.json"
                        },
                        url = "http://json.schemastore.org/stylelintrc.json"
                    }, {
                        fileMatch = {"/.github/workflows/*"},
                        url = "https://json.schemastore.org/github-workflow.json"
                    }
                }
            }
        }
    end,
    ["gopls"] = function(opts)
        opts.settings = {
            gopls = {
                usePlaceholders = true,
                analyses = {
                    nilness = true,
                    shadow = true,
                    unusedparams = true,
                    unusewrites = true
                }
            }
        }
    end
}

lsp_installer.on_server_ready(function(server)
    local opts = {
        capabilities = capabilities,
        flags = {debounce_text_changes = 500},
        on_attach = custom_attach
    }

    if enhance_server_opts[server.name] then
        enhance_server_opts[server.name](opts)
    end

    server:setup(opts)
end)

nvim_lsp.html.setup {
    cmd = {"html-languageserver", "--stdio"},
    filetypes = {"html"},
    init_options = {
        configurationSection = {"html", "css", "javascript"},
        embeddedLanguages = {css = true, javascript = true}
    },
    settings = {},
    single_file_support = true,
    flags = {debounce_text_changes = 500},
    capabilities = capabilities,
    on_attach = custom_attach
}
