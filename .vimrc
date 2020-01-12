let g:ctags_statusline=1
let generate_tags=1
let g:ctags_title=1
set autochdir
set csre
set tags=tags;
set noswapfile
set title
" '+' is the clipboard register - this is a shortcut to paste from clipboard
"and move the cursoe to after the pasted text
nnoremap cv "+gP
nnoremap cb "*gP
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /^\t* \+\|\s\+$/
set hlsearch
"see http://vim.wikia.com/wiki/Insert_a_single_character
nnoremap s :exec "normal i".nr2char(getchar())."\e"<CR>
nnoremap S :exec "normal a".nr2char(getchar())."\e"<CR>

"nnoremap C :exec "normal a".\/\/."\e"<CR>

autocmd FileType c,cpp :set sw=8 cindent smarttab
autocmd FileType sh setlocal ts=4 sw=4 sts=0
"bands jj to <ESC>, see https://vi.stackexchange.com/a/301/20051
inoremap jj <ESC>
"this auto ident when pasting
nnoremap p p=`]
nnoremap P P=`]
set clipboard=unnamedplus
syntax on
