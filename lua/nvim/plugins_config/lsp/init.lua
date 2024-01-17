local mod_prefix = 'mynvim/plugins-config/lsp/'

require("mason").setup()
require("mason-lspconfig").setup()
require("lspsaga").setup({lightbulb = {enable = false}})

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

lightbulb_config = {
    sign = {
        enabled = false
    },
    float = {
        enabled = true
    },
    status_text = {
        enabled = false
    },
    virtual_text = {
        enabled = false
    },
    line = {
        enabled = false
    },
    autocmd = { enabled = true },
}

require("nvim-lightbulb").setup(lightbulb_config)
