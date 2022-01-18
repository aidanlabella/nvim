vim.api.nvim_exec(
[[
    set autoindent
    set expandtab
    set laststatus=2
    set hidden
    set updatetime=300
    set timeoutlen=250
    set mouse=a
    set number

    cnoreabbrev W w
    cnoreabbrev Q q

    set t_Co=256
    set guifont=Consolas:h10

    "let g:javascript_plugin_jsdoc = 1

    "
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
    "highlight Normal ctermbg=NONE
    "highlight nonText ctermbg=NONE
    "

    set termguicolors
]],
false)
