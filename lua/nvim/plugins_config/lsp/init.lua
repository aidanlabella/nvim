local mod_prefix = 'mynvim/plugins-config/lsp/'

require("mason").setup()
require("mason-lspconfig").setup()
require("lspsaga").setup({lightbulb = {enable = false}, symbol_in_winbar = {enable = false}})

local capabilities = require('blink.cmp').get_lsp_capabilities()

vim.lsp.enable({
  -- lua
  "luals",
  -- nix
  "nil_ls",
  "nixd",
  -- python
  "pyright",
  "ruff",
  -- markdown
  "ltex",
  -- terraform
  "terraformls",
  -- yaml
  "yamlls",
  -- bash
  "bashls"
})
----local capabilities = vim.lsp.protocol.make_client_capabilities()
--capabilities.textDocument.completion.completionItem.snippetSupport = true

---- Configure LSP servers here
---- ECMA Script
--vim.lsp.config.ts_ls.setup {on_attach = on_attach, capabilities = capabilities}

---- C/C++
--vim.lsp.config.clangd.setup {on_attach = on_attach, capabilities = capabilities}

---- Python
----vim.lsp.config.jedi_language_server.setup { on_attach = on_attach, capabilities = capabilities }
----vim.lsp.config.pyright.setup {capabilities = capabilities}
--vim.lsp.config.pylsp.setup {
    --capabilities = capabilities,
    --settings = {
        --pylsp = {
            --plugins = {
                --jedi_completion = {
                    --include_params = true,
                --},
                --pylint = { enabled = true }, -- Disable pylint
                --pyflakes = { enabled = true }, -- Disable pyflakes
                --pycodestyle = { enabled = false }, -- Disable pycodestyle
            --},
        --},
    --},
--}
---- PHP
--vim.lsp.config.intelephense.setup {on_attach = on_attach, capabilities = capabilities}

---- SQL
--vim.lsp.config.sqlls.setup {on_attach = on_attach, capabilities = capabilities}
---- bash
--vim.lsp.config.bashls.setup {on_attach = on_attach, capabilities = capabilities}

---- Latek
--vim.lsp.config.ltex.setup {on_attach = on_attach, capabilities = capabilities}
--vim.lsp.config.texlab.setup {on_attach = on_attach, capabilities = capabilities}

---- Markdown
--vim.lsp.config.marksman.setup {on_attach = on_attach, capabilities = capabilities}

---- Java
--vim.lsp.config.jdtls.setup {
    --vmargs = {
        --"-XX:+UseParallelGC",
        --"-XX:GCTimeRatio=4",
        --"-XX:AdaptiveSizePolicyWeight=90",
        --"-Dsun.zip.disableMemoryMapping=true",
        --"-Djava.import.generatesMetadataFilesAtProjectRoot=false",
        --"-Xmx1G",
        --"-Xms100m",
    --},
    --capabilities = {
        --textDocument = {
              --completion = {
                --completionItem = {
                    --snippetSupport = true
                --}
            --}
        --}
    --},
    --on_attach = on_attach,
--}
