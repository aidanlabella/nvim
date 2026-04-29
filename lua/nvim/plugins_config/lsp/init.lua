local mod_prefix = 'mynvim/plugins-config/lsp/'

require("mason").setup()
require("lspsaga").setup({lightbulb = {enable = false}, symbol_in_winbar = {enable = false}})

local coq = require("coq")

local servers = {
  -- lua
  "lua_ls",
  -- nix
  "nil_ls",
  "nixd",
  -- python
  "basedpyright",
  "ruff",
  -- markdown
  "ltex",
  -- terraform
  "terraformls",
  -- yaml
  "yamlls",
  -- bash
  "bashls"
}

local mason_servers = {
  -- lua
  "lua_ls",
  -- nix
  "nil_ls",
  -- python
  "basedpyright",
  "ruff",
  -- markdown
  "ltex",
  -- terraform
  "terraformls",
  -- yaml
  "yamlls",
  -- bash
  "bashls"
}

require("mason-lspconfig").setup({
  ensure_installed = mason_servers,
  automatic_enable = false,
})

for _, server in ipairs(servers) do
  vim.lsp.config(server, coq.lsp_ensure_capabilities({}))
end

vim.lsp.config("basedpyright", coq.lsp_ensure_capabilities({
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "standard",
        diagnosticMode = "openFilesOnly",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        autoImportCompletions = true,
        inlayHints = {
          variableTypes = true,
          functionReturnTypes = true,
          callArgumentNames = true,
          genericTypes = false,
        },
      },
    },
  },
}))

vim.lsp.config("ruff", coq.lsp_ensure_capabilities({
  init_options = {
    settings = {
      organizeImports = true,
      fixAll = true,
    },
  },
}))

vim.lsp.enable(servers)
