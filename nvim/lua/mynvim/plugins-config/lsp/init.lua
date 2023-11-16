local mod_prefix = 'mynvim/plugins-config/lsp/'

require("mason").setup()
require("mason-lspconfig").setup()
local lspconfig = require('lspconfig')
local navic = require("nvim-navic")

local function on_attach(client, bufnr)
    navic.attach(client, bufnr)
    -- set up buffer keymaps, etc.
end

--vim.env.JAVA_HOME = '/opt/homebrew/opt/java'


-- Configure LSP servers here
lspconfig.tsserver.setup { on_attach = on_attach }
lspconfig.clangd.setup {
    capabilities = {
        textDocument = {
              completion = {
                completionItem = {
                    snippetSupport = true
                }
            }
        }
    },
    on_attach = on_attach
}

lspconfig.pyright.setup { on_attach = on_attach }
lspconfig.intelephense.setup { on_attach = on_attach }
lspconfig.sqlls.setup { on_attach = on_attach }
lspconfig.bashls.setup { on_attach = on_attach }
lspconfig.ltex.setup { on_attach = on_attach }
lspconfig.texlab.setup { on_attach = on_attach }
lspconfig.marksman.setup { on_attach = on_attach }

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
