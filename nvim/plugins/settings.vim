"Neovim configruation files
"Author: Aidan LaBella - Brown University Department of Computer Science
"Email: alabella@brown.edu 
"
"plugins/settings.vim
"configure plugin settings
"BarBar

"NVIMTree



"if exists('*complete_info')
  "inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
"else
  "inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"endif


"function! s:check_back_space() abort
  "let col = col('.') - 1
  "return !col || getline('.')[col - 1]  =~ '\s'
"endfunction

"inoremap <silent><expr> <Tab>
      "\ pumvisible() ? "\<C-n>" :
      "\ <SID>check_back_space() ? "\<Tab>" :
      "\ coc#refresh()

"Code-Minimap

"Ranger

"Dashboard
