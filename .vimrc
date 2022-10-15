set backspace=indent,eol,start
set mouse=a
set ttymouse=xterm2
syntax on
set t_Co=256¬
set termguicolors
set clipboard=unnamed,autoselect
set smartindent
set softtabstop=2
set showmatch matchtime=1
set cmdheight=2
set laststatus=2
set ignorecase
set smartcase
set wrapscan
set incsearch
set hlsearch
set expandtab
set tabstop=2
set shiftwidth=2
set laststatus=2
set statusline=%F%r%h%=%l%c%p
inoremap <silent> jj <ESC>
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 5

call plug#begin('~/.vim/plugged')
call plug#end()

if has('mac')
inoremap <ESC> <ESC>:call ImInActivate()<CR>
  function! ImInActivate()
    call system("im-select 'com.apple.keylayout.ABC'")
  endfunction
endif
