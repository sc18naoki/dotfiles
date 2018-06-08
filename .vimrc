"vimrc
"requirement:vim=NVIM v0.2.0 or later

"----------------------------------------------------------------------------
"configuration
"----------------------------------------------------------------------------
"appearance
set number
set display=lastline
set pumheight=10
set statusline=%y%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}\ %r%h%w%F%m%=ROW=%l/%L,COL=%c\ %{ObsessionStatus()}%{fugitive#statusline()}
set laststatus=2
"backup
set backup
set backupdir=~/.local/share/nvim/backup 
set undofile
set undodir=~/.local/share/nvim/undo
"indent
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
"search
set hlsearch
set incsearch
set wrapscan
set ignorecase
set smartcase
"backspace for deletion
set backspace=indent,eol,start
"yank
nnoremap Y y$
"insert blank line(:0=zero, not o/O)
nnoremap <silent> 0 :<C-u>call append(expand('.'), '')<Cr>j
"cursor:normal mode
nnoremap <silent>j gj
nnoremap <silent>k gk
"cursor:insert mode
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>^
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-j> <Down>
inoremap <C-k> <UP>
"cursor:command mode
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-k> <C-E><C-U>
"window resize;horizontally{increase/decrease},vertically{increase/decrease}
nnoremap <silent>+ 3<C-w>+
nnoremap <silent>_ 3<C-w>-
nnoremap <silent>= 3<C-w>>
nnoremap <silent>- 3<C-w><
"remenber last cursor position
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END
"clipboard integration
set clipboard+=unnamedplus
"drawing ZENKAKU symbol
set ambiwidth=double
"highlight
highlight Search ctermfg=0 ctermbg=11 guifg=Blue guibg=Yellow
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17
highlight DiffText   cterm=bold ctermfg=10 ctermbg=21
highlight NonText cterm=bold ctermfg=248 guifg=248

""sub prefix
nnoremap [sub] <Nop>
nmap s [sub]
nnoremap [SUB] <Nop>
nmap S [SUB]
"substituiton
nnoremap [sub]* *:%s/<C-r>///gI<Left><Left><Left>
nnoremap [sub]s :%s///gI<Left><Left><Left><Left>
"Diff last_save/last_backup
nnoremap <silent> [sub]d :DiffOrig<CR>
"buffer (list,reload,next,previous)
set hidden
nnoremap <silent> [sub]n :bn<CR>
nnoremap <silent> [sub]p :bp<CR>
nnoremap <silent> <Leader>q :bd %<CR>
nnoremap <silent> <Leader>Q :BufDel<CR>
""fzf.vim
nnoremap <silent> [sub]l :Buffers<CR>
nnoremap <silent> [sub]m :Marks<CR>
nnoremap <silent> [sub]w :Windows<CR>
nnoremap <silent> [sub]y :History<CR>
nnoremap <silent> [sub]: :History:<CR>
nnoremap <silent> [sub]. :BLines<CR>
nnoremap <silent> [sub]/ :Lines<CR>
nnoremap <silent> [sub]o :BTags<CR>
nnoremap <silent> [sub]t :Tags<CR>
nnoremap <silent> [sub]f :Files<CR>
nnoremap <silent> [sub]g :Ag<CR>
nnoremap <silent> [sub]? :Commands<CR>
"nerdtree
nnoremap <silent> <Leader>n :NERDTreeTabsToggle<CR>
"undotree
nnoremap <silent> <Leader>u :MundoToggle<CR>
"tagbar
nnoremap <silent> <Leader>t :TagbarToggle<CR>
"neosnippet
nnoremap <silent> [SUB]E :NeoSnippetEdit<CR>
"fugitive;Commits(fzf)
nnoremap <silent> <Leader>s :Gstatus<CR>
nnoremap <silent> <Leader>a :Gwrite<CR>
nnoremap <silent> <Leader>c :Gcommit<CR>
nnoremap <silent> <Leader>d :Gvdiff<CR>
nnoremap <silent> <Leader>b :Gblame<CR>
nnoremap <silent> <Leader>l :Commits<CR>
"vim-obsession;{create/halt-recording},destroy
nnoremap <Leader>o :Obsession<CR>
nnoremap <Leader>O :Obsession!<CR>
"Vimrc
nnoremap <silent> [SUB]v :Vimrc<CR>
nnoremap <silent> [SUB]V :Vimrcall<CR>
"force write ReadOnly;manual operation is mandatory!!
nnoremap [SUB]W :w !sudo tee % > /dev/null

""user defined function/command
"Comp <- copare files side by side
function! s:compare(...)
  if a:0 == 1
    tabedit %:p
	setl scrollbind
    exec 'rightbelow vnew ' . a:1
	setl scrollbind
  else
    exec 'tabedit ' . a:1
    setl scrollbind
    for l:file in a:000[1 :]
      exec 'rightbelow vnew ' . l:file
      setl scrollbind
    endfor
  endif
endfunction
command! -bar -nargs=+ -complete=file Compare  call s:compare(<f-args>)
"DeleteHiddenBuffers <- delete hidden buffer
function DeleteHiddenBuffers()
    let tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        silent execute 'bwipeout' buf
    endfor
endfunction
command! BufDel call DeleteHiddenBuffers()
"Diff <- diff view
function! s:vimdiff_in_newtab(...)
  if a:0 == 1
    tabedit %:p
    exec 'rightbelow vertical diffsplit ' . a:1
  else
    exec 'tabedit ' . a:1
    for l:file in a:000[1 :]
      exec 'rightbelow vertical diffsplit ' . l:file
    endfor
  endif
endfunction
command! -bar -nargs=+ -complete=file Diff  call s:vimdiff_in_newtab(<f-args>)
"DiffOrig <- show modified from last change
command DiffOrig tabedit % | rightb vert new | set buftype=nofile | read ++edit # | 0d_| diffthis | wincmd p | diffthis
"HandleURI <- open url with preset browser
function! HandleURI()
  let l:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;:]*')
  echo l:uri
  if l:uri != ""
    exec "!xdg-open \"" . l:uri . "\""
  else
    echo "No URI found in line."
  endif
endfunction
nnoremap <Leader>w :<C-u>call HandleURI()<CR>
"Vimrc <- open ~/.vimrc with tab
command! Vimrc tablast | tabedit ~/.vimrc
command! Vimrcall tablast | tabedit ~/.vimrc | tabedit ~/.dein.toml | tabedit ~/.dein_lazy.toml | tabp | tabp

""tab control
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2
"prefix
nnoremap    [Tab]   <Nop>
nmap    t [Tab]
"jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tab]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
"create,edit,close,next(last),previous(first),only,tag,path
nnoremap <silent> [Tab]t :tablast <bar> tabnew<CR>
nnoremap <silent> [Tab]w :tabclose<CR>
nnoremap <silent> [Tab]n :tabnext<CR>
nnoremap <silent> [Tab]N :tabl<CR>
nnoremap <silent> [Tab]p :tabprevious<CR>
nnoremap <silent> [Tab]P :tabfir<CR>
nnoremap <silent> [Tab]o :tabonly<CR>
nnoremap <silent> [Tab]<C-]> <C-w><C-]><C-w>T
nnoremap <silent> [Tab]f <C-w>gf

""FILETYPE
"vim:open help with K,close with q
autocmd Filetype vim set keywordprg=:help
autocmd FileType help,ref* nnoremap <buffer> q <C-w>c
"c:gf{path_to_header} <- add path when neccessary
augroup GfPathGroup
  autocmd!
  autocmd FileType c setlocal path+=/usr/local/include,/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/macosx.sdk/usr/include,/Users/naoki/scripts/src/util-linux/util-linux-2.31-rc1/include
augroup END

"ctags;search ".tags" file until $HOME
set tags=.tags;~

"----------------------------------------------------------------------------
"plugin initialization
"----------------------------------------------------------------------------
if &compatible
  set nocompatible
endif

let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let s:toml = '~/.dein.toml'
  let s:lazy_toml = '~/.dein_lazy.toml'
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif
filetype plugin indent on
syntax on

