local mod_prefix = 'plugins-config/lsp/'
require(mod_prefix .. 'lspkind')
require(mod_prefix .. 'saga')

local function setup_servers()
  require'lspinstall'.setup()
  local servers = require'lspinstall'.installed_servers()
  for _, server in pairs(servers) do
    require'lspconfig'[server].setup{
        capabilities = {
            textDocument = {
              completion = {
                completionItem = {
                  snippetSupport = true
                }
          }
        }
      },
    }
  end
end

setup_servers()
--local coq = require "coq" -- add this

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end



vim.api.nvim_exec(
[[
    let g:coq_settings = { 'auto_start': v:true }
]], false)
