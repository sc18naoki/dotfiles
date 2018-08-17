"vimrc
"requirement:vim=NVIM v0.2.0 or later

"----------------------------------------------------------------------------
"configuration
"----------------------------------------------------------------------------
"appearance
set number
set display=lastline
set pumheight=10
set statusline=%y\ %r%h%w%-0.37f%m%=ROW=%l/%L,COL=%c\ %{ObsessionStatus()}%{LinterStatus()}
set laststatus=2
"backup
set backup
set backupdir=~/.local/share/nvim/backup 
set undofile
set undodir=~/.local/share/nvim/undo
"indent
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set breakindent
"search
set hlsearch
set incsearch
set wrapscan
set ignorecase
set smartcase
nmap n <Plug>(anzu-n-with-echo)
nmap gn <Plug>(anzu-jump-n)<Plug>(anzu-echo-search-status)
nmap N <Plug>(anzu-N-with-echo)
nmap gN <Plug>(anzu-jump-N)<Plug>(anzu-echo-search-status)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)
nnoremap <silent> <Esc><Esc> :noh<CR>
"backspace for deletion
set backspace=indent,eol,start
"yank
nnoremap Y y$
"x w/o register
nnoremap x "_x
"insert blank line
nmap <silent> go :<C-u>call append(expand('.'), '')<Cr>j
"increment/decrement by ignoring minus-prefix
nmap <silent> g<C-a> <Plug>(trip-increment-ignore-minus)
nmap <silent> g<C-x> <Plug>(trip-decrement-ignore-minus)
"cursor:normal mode
nnoremap j gj
nnoremap k gk
nnoremap gh ^
nnoremap gl $
nmap <C-j> <Plug>(edgemotion-j)
nmap <C-k> <Plug>(edgemotion-k)
"cursor:insert mode
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>^
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-k> <Up>
inoremap <C-j> <Down>
"cursor:command mode
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-k> <C-E><C-U>
"window control
"resize
nnoremap <silent>+ 3<C-w>+
nnoremap <silent>_ 3<C-w>-
nnoremap <silent>= 3<C-w>>
nnoremap <silent>- 3<C-w><
"gf
nnoremap <C-w>f :vertical rightbelow wincmd f<CR>
nnoremap <C-w>gf :rightbelow wincmd f<CR>
"tag jump
nnoremap <C-w>] :vertical rightbelow wincmd ]<CR>
nnoremap <C-w><C-]> :rightbelow wincmd ]<CR>
"scrollbind shortcut
nnoremap <silent> <Leader>b :call ScrollBind()<CR>
"remenber last cursor position
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END
"clipboard integration
set clipboard+=unnamedplus
"drawing ZENKAKU symbol
set ambiwidth=double
""system
"updatetime: decrease delay from 4000 to 100
set updatetime=100

""keybindings
"prefix
nnoremap [sub] <Nop>
nmap s [sub]
"substituiton
nnoremap [sub]* *:%s/<C-r>///gI<Left><Left><Left>
nnoremap [sub]s :%s///gI<Left><Left><Left><Left>
"Diff
nnoremap <silent> [sub]d :DiffOrig<CR>
"buffer
set hidden
nnoremap <silent> [sub]n :bn<CR>
nnoremap <silent> [sub]p :bp<CR>
nnoremap <silent> <Leader>q :BD<CR>
nnoremap <silent> <Leader>Q :BufDel<CR>
"fzf.vim
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
nnoremap <silent> [sub]h :Helptags<CR>
"neosnippet
nnoremap <silent> [sub]e :NeoSnippetEdit<CR>
"save/write
nnoremap <Leader>W :w !sudo tee % > /dev/null
"nerdtree
nnoremap <silent> <Space>n :NERDTreeTabsToggle<CR>
"undotree
nnoremap <silent> <Space>u :MundoToggle<CR>
"tagbar
nnoremap <silent> <Space>t :TagbarToggle<CR>
"git:fugitive;fzf;GitGutter
nnoremap [git] <Nop>
nmap <Space>g [git]
nnoremap <silent> [git]s :Gstatus<CR>
nnoremap <silent> [git]d :Gvdiff<CR>
nnoremap <silent> [git]m :GFiles?<CR>
nnoremap <silent> [git]v :GitGutterPreviewHunk<CR><C-w>b
nnoremap <silent> [git]p :GitGutterPrevHunk<CR>
nnoremap <silent> [git]n :GitGutterNextHunk<CR>
nnoremap <silent> [git]b :Gblame<CR>
nnoremap <silent> [git]c :BCommits<CR>
nnoremap <silent> [git]l :Commits<CR>
"vim-obsession;{create/halt-recording},destroy
nnoremap <silent> <Leader>o :Obsession<CR>
nnoremap <silent> <Leader>O :Obsession!<CR>
"ALE: Toggle on/off
nnoremap <silent> <Leader>A :ALEToggle<CR>
"GitGutter: Toggle on/off
nnoremap <silent> <Leader>G :GitGutterToggle<CR>

""function
"Comp = copare files side by side
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
"DeleteHiddenBuffers = delete hidden buffer
function DeleteHiddenBuffers()
    let tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        silent execute 'bwipeout' buf
    endfor
endfunction
command! BufDel call DeleteHiddenBuffers()
"Diff = diff view
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
"DiffOrig = show modified from last change
command DiffOrig tabedit % | rightb vert new | set buftype=nofile | read ++edit # | 0d_| diffthis | wincmd p | diffthis
"HandleURI = open url with preset browser
function! HandleURI()
  let l:uri = matchstr(getline('.'), '[a-z]*:\/\/[^ >,;:]*')
  echo l:uri
  if l:uri !=# ''
    exec "!xdg-open \"" . l:uri . "\""
  else
    echo 'No URI found in line.'
  endif
endfunction
nnoremap <Leader>w :<C-u>call HandleURI()<CR>
"ScrollBind = scrollbind both window
function! ScrollBind(...)
  let l:curr_bufnr = bufnr('%')
  let g:scb_status = ( a:0 > 0 ? a:1 : !exists('g:scb_status') || !g:scb_status )
  if !exists('g:scb_pos') | let g:scb_pos = {} | endif

  let l:loop_cont = 1
  while l:loop_cont
    setl noscrollbind
    if !g:scb_status && has_key( g:scb_pos, bufnr('%') )
      call setpos( '.', g:scb_pos[ bufnr('%') ] )
    endif
    execute 'wincmd w'
    let l:loop_cont = !( l:curr_bufnr == bufnr('%') )
  endwhile

  if g:scb_status
    let l:loop_cont = 1
    while l:loop_cont
      let g:scb_pos[ bufnr('%') ] = getpos( '.' )
      normal! gg
      setl scrollbind
      execute 'wincmd w'
      let l:loop_cont = !( l:curr_bufnr == bufnr('%') )
    endwhile
  else
    let g:scb_pos = {}
  endif
endfunction
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
nnoremap <silent> [Tab]T :tabnew<CR>
nnoremap <silent> [Tab]w :tabclose<CR>
nnoremap <silent> [Tab]o :tabonly<CR>
nnoremap <silent> [Tab]n :tabnext<CR>
nnoremap <silent> [Tab]N :tabl<CR>
nnoremap <silent> [Tab]p :tabprevious<CR>
nnoremap <silent> [Tab]P :tabfir<CR>
nnoremap <silent> [Tab]<C-]> <C-w><C-]><C-w>T
nnoremap <silent> [Tab]f <C-w>gf
nnoremap <silent> [Tab]m :wincmd T<CR>

"AUTO
augroup KeywordSearch
  autocmd!
  autocmd Filetype vim set keywordprg=:help
augroup END
augroup QuickQuit
  autocmd!
  autocmd FileType help,diff,Preview,ref* nnoremap <buffer> q <C-w>c
augroup END
augroup RubyConf
  autocmd!
  autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 iskeyword+=?
augroup END
augroup ForceFileType
    autocmd!
    autocmd BufNewFile,BufRead *.xaml setfiletype xml
augroup END

"ctags;search ".tags" file until $HOME
set tags=.tags;~
"hide preview window
set completeopt-=preview

"""project specific configuration
"" -> "/projectpath/.vimconf" to load
"augroup ProjectVim
"  autocmd!
"  autocmd BufEnter * call s:vimrc_local(expand('<afile>:p:h'))
"augroup END
"
"function! s:vimrc_local(loc)
"  let files = findfile('.vimconf', escape(a:loc, ' ') . ';', -1)
"  for i in reverse(filter(files, 'filereadable(v:val)'))
"    source `=i`
"  endfor
"endfunction

"----------------------------------------------------------------------------
"plugin initialization
"----------------------------------------------------------------------------
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

"----------------------------------------------------------------------------
"finalize
"----------------------------------------------------------------------------
filetype plugin indent on
syntax on
"colorscheme
colorscheme dante
"highlight
highlight HighlightWords ctermfg=black ctermbg=yellow
match HighlightWords /TODO\|NOTE\|MEMO/
highlight Search ctermfg=0 ctermbg=11 guifg=Blue guibg=Yellow
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17
highlight DiffText   cterm=bold ctermfg=10 ctermbg=21
highlight NonText cterm=bold ctermfg=248 guifg=248
