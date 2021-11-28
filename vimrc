let g:ctags_statusline=1
let generate_tags=1
let g:ctags_title=1
set autochdir
set csre
set tags=tags;
set noswapfile
set title
set colorcolumn=100

"set relativenumber
"set number
" '+' is the clipboard register - this is a shortcut to paste from clipboard
"For this to work install vim-gnome
"and move the cursoe to after the pasted text
nnoremap cv "+gP

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /^\t* \+\|\s\+$/
set hlsearch
"see http://vim.wikia.com/wiki/Insert_a_single_character
"nnoremap s :exec "normal i".nr2char(getchar())."\e"<CR>
"nnoremap S :exec "normal a".nr2char(getchar())."\e"<CR>

"nnoremap C :exec "normal a".\/\/."\e"<CR>


autocmd FileType c,cpp :set sw=8 cindent smarttab
autocmd FileType sh setlocal ts=4 sw=4 sts=0
autocmd FileType python setlocal ts=4 sw=4 sts=0 expandtab
"bands jj to <ESC>, see https://vi.stackexchange.com/a/301/20051
inoremap jj <ESC>
"this auto ident when pasting, see https://vim.fandom.com/wiki/Format_pasted_text_automatically
nnoremap p p=`]
"nnoremap P P=`]
"set autoindent
"set cindent

"paste after current line, see https://stackoverflow.com/a/1346747/1019140
:nmap K :pu<CR>
:nmap KK :pu!<CR>

"Syntax highlighting
syntax on


set showtabline=2 " always show tabs

" from https://stackoverflow.com/questions/2415237/techniques-in-git-grep-and-vim#2415366
func GitGrep(...)
  let save = &grepprg
  set grepprg=git\ grep\ -n\ $*
  let s = 'grep!' " the '!' is to prevent jumping to the first match
  for i in a:000
    let s = s . ' ' . i
  endfor
  exe s
  copen "automatically open to quickfix list
  let &grepprg = save
endfun
command -nargs=? G call GitGrep(<f-args>)

" from https://stackoverflow.com/questions/2415237/techniques-in-git-grep-and-vim#2415366
func TopGitGrep(...)
  let save = &grepprg
  set grepprg=git\ grep\ -n\ $*
  "get the top dir of the git project, [:-2] is to get rid of the newline at the end
  let topgit = system('git rev-parse --show-toplevel')[:-2]

  "cd to top git project (cd topgit) won't work, see https://stackoverflow.com/questions/4596932/vim-cd-to-path-stored-in-variable
  exe 'cd ' . topgit

  let s = 'grep!' " the '!' is to prevent jumping to the first match
  for i in a:000 "iterates the list of variables to func 'TopGitGrep', see :h a:000
    let s = s . ' ' . i
  endfor
  exe s
  copen "automatically open to quickfix list
  pwd
  "at this point we are in the top git directory becuase of the 'cd' command so clicking files in the quicklist will bring us to the file
  let &grepprg = save
endfun
command -nargs=? T call TopGitGrep(<f-args>)



" from https://stackoverflow.com/a/33765365/1019140
set tabline=%!MyTabLine()  " custom tab pages line
function! MyTabLine()
  let s = ''
  " loop through each tab page
  for i in range(tabpagenr('$'))
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#' " WildMenu
    else
      let s .= '%#Title#'
    endif
    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T '
    " set page number string
    let s .= i + 1 . ''
    " get buffer names and statuses
    let n = ''  " temp str for buf names
    let m = 0   " &modified counter
    let buflist = tabpagebuflist(i + 1)
    " loop through each buffer in a tab
    for b in buflist
      if getbufvar(b, "&buftype") == 'help'
        " let n .= '[H]' . fnamemodify(bufname(b), ':t:s/.txt$//')
      elseif getbufvar(b, "&buftype") == 'quickfix'
        " let n .= '[Q]'
      elseif getbufvar(b, "&modifiable")
        let n .= fnamemodify(bufname(b), ':t') . ', ' " pathshorten(bufname(b))
      endif
      if getbufvar(b, "&modified")
        let m += 1
      endif
    endfor
    " let n .= fnamemodify(bufname(buflist[tabpagewinnr(i + 1) - 1]), ':t')
    let n = substitute(n, ', $', '', '')
    " add modified label
    if m > 0
      let s .= '+'
      " let s .= '[' . m . '+]'
    endif
    if i + 1 == tabpagenr()
      let s .= ' %#TabLineSel#'
    else
      let s .= ' %#TabLine#'
    endif
    " add buffer names
    if n == ''
      let s.= '[New]'
    else
      let s .= n
    endif
    " switch to no underlining and add final space
    let s .= ' '
  endfor
  let s .= '%#TabLineFill#%T'
  " right-aligned close button
  " if tabpagenr('$') > 1
  "   let s .= '%=%#TabLineFill#%999Xclose'
  " endif
  return s
endfunction

