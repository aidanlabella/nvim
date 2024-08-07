local mod_prefix = 'mynvim/plugins-config/lsp/'

require("mason").setup()
require("mason-lspconfig").setup()
require("lspsaga").setup({lightbulb = {enable = false}})

local lspconfig = require('lspconfig')
local coq = require('coq')

-- Configure LSP servers here
-- ECMA Script
lspconfig.tsserver.setup {coq.lsp_ensure_capabilities({on_attach = on_attach, capabilities = capabilities})}

-- C/C++
lspconfig.clangd.setup {coq.lsp_ensure_capabilities({on_attach = on_attach, capabilities = capabilities})}

-- Python
--lspconfig.jedi_language_server.setup { on_attach = on_attach, capabilities = capabilities }
lspconfig.pyright.setup {coq.lsp_ensure_capabilities({on_attach = on_attach, capabilities = capabilities})}

-- PHP
lspconfig.intelephense.setup {coq.lsp_ensure_capabilities({on_attach = on_attach, capabilities = capabilities})}

-- SQL
lspconfig.sqlls.setup {coq.lsp_ensure_capabilities({on_attach = on_attach, capabilities = capabilities})}

-- bash
lspconfig.bashls.setup {coq.lsp_ensure_capabilities({on_attach = on_attach, capabilities = capabilities})}

-- Latek
lspconfig.ltex.setup {coq.lsp_ensure_capabilities({on_attach = on_attach, capabilities = capabilities})}
lspconfig.texlab.setup {coq.lsp_ensure_capabilities({on_attach = on_attach, capabilities = capabilities})}

-- Markdown
lspconfig.marksman.setup {coq.lsp_ensure_capabilities({on_attach = on_attach, capabilities = capabilities})}

-- Java
lspconfig.jdtls.setup {
    coq.lsp_ensure_capabilities({
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
    })
}
