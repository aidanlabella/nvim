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

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end


vim.api.nvim_exec(
[[
    let g:UltiSnipsExpandTrigger="<C-s>"

    autocmd BufEnter * lua require'completion'.on_attach()
    let g:completion_enable_snippet = 'vim-vsnip'
    inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

    " Set completeopt to have a better completion experience
    set completeopt=menuone,noinsert,noselect

    " Avoid showing message extra message when using completion
    set shortmess+=c
]], false)
