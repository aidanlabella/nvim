local mod_prefix = 'mynvim/plugins-config/lsp/'

require("mason").setup()
require("mason-lspconfig").setup()
local lspconfig = require('lspconfig')
local navic = require("nvim-navic")

local function on_attach(client, bufnr)
    navic.attach(client, bufnr)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Configure LSP servers here
-- ECMA Script
lspconfig.tsserver.setup { on_attach = on_attach, capabilities = capabilities }

-- C/C++
lspconfig.clangd.setup { on_attach = on_attach, capabilities = capabilities }

-- Python
lspconfig.jedi_language_server.setup { on_attach = on_attach, capabilities = capabilities }
lspconfig.pyright.setup {capabilities = capabilities }

-- PHP
lspconfig.intelephense.setup { on_attach = on_attach, capabilities = capabilities }

-- SQL
lspconfig.sqlls.setup { on_attach = on_attach, capabilities = capabilities }

-- bash
lspconfig.bashls.setup { on_attach = on_attach, capabilities = capabilities }

-- Latek
lspconfig.ltex.setup { on_attach = on_attach, capabilities = capabilities }
lspconfig.texlab.setup { on_attach = on_attach, capabilities = capabilities }

-- Markdown
lspconfig.marksman.setup { on_attach = on_attach, capabilities = capabilities }

-- Java
lspconfig.jdtls.setup {
    vmargs = {
        "-XX:+UseParallelGC",
        "-XX:GCTimeRatio=4",
        "-XX:AdaptiveSizePolicyWeight=90",
        "-Dsun.zip.disableMemoryMapping=true",
        "-Djava.import.generatesMetadataFilesAtProjectRoot=false",
        "-Xmx1G",
        "-Xms100m",
    },
    capabilities = {
        textDocument = {
              completion = {
                completionItem = {
                    snippetSupport = true
                }
            }
        }
    },
    on_attach = on_attach,
}

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
