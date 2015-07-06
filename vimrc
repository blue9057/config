" Vundle
set nocompatible
filetype on
set modeline
call plug#begin('~/.vim/plugged')

" Colorscheme
if has('gui_running')
  Plug 'wombat256.vim'
else
  Plug 'altercation/vim-colors-solarized'
  Plug 'khwon/vim-tomorrow-theme'
  Plug '29decibel/codeschool-vim-theme'
  Plug 'vim-scripts/BusyBee'
  Plug 'w0ng/vim-hybrid'
  Plug 'nanotech/jellybeans.vim'
  Plug 'jonathanfilip/vim-lucius'
endif

" 80 line
Plug 'vim-scripts/eighties.vim'
" Cscope maps
Plug 'khwon/cscope_maps.vim'
" tComment
Plug 'vim-scripts/tComment'

" taglist
Plug 'vim-scripts/taglist.vim'
" Easytags
Plug 'xolox/vim-easytags'
Plug 'xolox/vim-misc'

Plug 'vim-javascript'
" General
" Preserve missing EOL at the end of text files
Plug 'PreserveNoEOL'
" ANSI escape
Plug 'AnsiEsc.vim', { 'for': 'railslog' }
" Full path finder
Plug 'kien/ctrlp.vim'
" Go to Terminal or File manager
Plug 'justinmk/vim-gtfo'
" Much simpler way to use some motions
Plug 'Lokaltog/vim-easymotion'
" Extended % matching
Plug 'matchit.zip'
" Autocomplete if end
Plug 'tpope/vim-endwise'
" Easily delete, change and add surroundings in pairs
Plug 'tpope/vim-surround'
" Pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'
" Vim sugar for the UNIX shell commands
Plug 'tpope/vim-eunuch'
" Compile errors
"Plug 'scrooloose/syntastic'
" Switch between source files and header files
Plug 'a.vim'
" Git wrapper
Plug 'tpope/vim-fugitive'
" Enable repeating supported plugin maps with "."
Plug 'tpope/vim-repeat'


" Status, tabline
Plug 'bling/vim-airline'
" Explore filesystem
Plug 'scrooloose/nerdtree'
" Show a git diff in the gutter and stages/reverts hunks
Plug 'airblade/vim-gitgutter'

" ConqueTerm
" Plug 'Conque-Shell'
Plug 'yous/conque', { 'on': [
      \ 'ConqueTerm',
      \ 'ConqueTermSplit',
      \ 'ConqueTermVSplit',
      \ 'ConqueTermTab'] }

" Support file types
" AdBlock
Plug 'mojako/adblock-filter.vim', { 'for': 'adblockfilter' }
" Aheui
Plug 'yous/aheui.vim', { 'for': 'aheui' }
" Coffee script
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
" Cucumber
Plug 'tpope/vim-cucumber', { 'for': 'cucumber' }
" Jade
Plug 'digitaltoad/vim-jade', { 'for': 'jade' }
" JSON
Plug 'elzr/vim-json', { 'for': 'json' }
" HTML5
Plug 'othree/html5.vim'
" LaTeX
Plug 'LaTeX-Suite-aka-Vim-LaTeX', { 'for': 'tex' }
" Markdown
Plug 'godlygeek/tabular', { 'for': 'mkd' }
Plug 'plasticboy/vim-markdown', { 'for': 'mkd' }
" PHP
Plug 'php.vim-html-enhanced'
" Racket
Plug 'wlangstroth/vim-racket', { 'for': 'racket' }
" TomDoc
Plug 'wellbredgrapefruit/tomdoc.vim', { 'for': ['coffee', 'ruby'] }
" XML
Plug 'othree/xml.vim', { 'for': 'xml' }

" Ruby
" Rake
Plug 'tpope/vim-rake'
" RuboCop
Plug 'ngmy/vim-rubocop', { 'on': 'RuboCop' }
" Rails
Plug 'tpope/vim-rails'

call plug#end()

" Setup
filetype plugin indent on
syntax on

" General
if &shell =~# 'fish$'
	set shell=sh
endif
set autoread
set background=dark
set backspace=indent,eol,start
set clipboard=unnamed
set fileencodings=ucs-bom,utf-8,cp949,latin1
set fileformats=unix,mac,dos
set history=1000
set ignorecase " Smartcase search
set incsearch
set nobackup
set smartcase
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set ttimeout
set ttimeoutlen=100
set wildignore+=.git,.hg,.svn
set wildignore+=*.bmp,*.gif,*.jpeg,*.jpg,*.png
set wildignore+=*.dll,*.exe,*.o,*.obj
set wildignore+=*.sw?
set wildignore+=*.DS_Store
set wildignore+=*.pyc
set wildmenu

if has('win32')
  autocmd InsertEnter * set noimdisable
  autocmd InsertLeave * set imdisable
  autocmd FocusGained * set imdisable
  autocmd FocusLost * set noimdisable
  language messages en
  set directory=.,$TEMP
  set shellslash
endif
autocmd InsertLeave * set nopaste

" VIM UI
set display+=lastline " Show as much as possible of the last line
set display+=uhex " Show unprintable characters as a hex number
set hlsearch " Search with highlight
set laststatus=2
set number
set nrformats-=octal
set scrolloff=3
set showcmd
set showmatch
set sidescroll=1
set sidescrolloff=10
set splitbelow
set splitright
set title
set t_Co=256


if has('gui_running')
	colorscheme wombat256mod
  else
	"colorscheme solarized
	colorscheme Tomorrow-Night
endif

augroup colorcolumn
  autocmd!
  if exists('+colorcolumn')
    set colorcolumn=81
  else
    autocmd BufWinEnter * let w:m2 = matchadd('ErrorMsg', '\%>80v.\+', -1)
  endif
augroup END

" GUI
if has('gui_running')
  set encoding=utf-8
  set guifont=DejaVu\ Sans\ Mono:h10:cANSI
  set guioptions-=m " Menu bar
  set guioptions-=T " Toolbar
  set guioptions-=r " Right-hand scrollbar
  set guioptions-=L " Left-hand scrollbar when window is vertically split
  set mouse=

  source $VIMRUNTIME/delmenu.vim
  set langmenu=ko.UTF-8
  source $VIMRUNTIME/menu.vim

  if has('win32')
    set guifontwide=DotumChe:h10:cDEFAULT
  endif

  function! ScreenFilename()
    if has('amiga')
      return 's:.vimsize'
    elseif has('win32')
      return $HOME.'\_vimsize'
    else
      return $HOME.'/.vimsize'
    endif
  endfunction
  function! ScreenRestore()
    " Restore window size (columns and lines) and position
    " from values stored in vimsize file.
    " Must set font first so columns and lines are based on font size.
    let f = ScreenFilename()
    if has('gui_running') && g:screen_size_restore_pos && filereadable(f)
      let vim_instance =
            \ (g:screen_size_by_vim_instance == 1 ? (v:servername) : 'GVIM')
      for line in readfile(f)
        let sizepos = split(line)
        if len(sizepos) == 5 && sizepos[0] == vim_instance
          silent! execute 'set columns='.sizepos[1].' lines='.sizepos[2]
          silent! execute 'winpos '.sizepos[3].' '.sizepos[4]
          return
        endif
      endfor
    endif
  endfunction
  function! ScreenSave()
    " Save window size and position.
    if has('gui_running') && g:screen_size_restore_pos
      let vim_instance =
            \ (g:screen_size_by_vim_instance == 1 ? (v:servername) : 'GVIM')
      let data = vim_instance.' '.&columns.' '.&lines.' '.
            \ (getwinposx() < 0 ? 0: getwinposx()).' '.
            \ (getwinposy() < 0 ? 0: getwinposy())
      let f = ScreenFilename()
      if filereadable(f)
        let lines = readfile(f)
        call filter(lines, "v:val !~ '^".vim_instance."\\>'")
        call add(lines, data)
      else
        let lines = [data]
      endif
      call writefile(lines, f)
    endif
  endfunction
  if !exists('g:screen_size_restore_pos')
    let g:screen_size_restore_pos = 1
  endif
  if !exists('g:screen_size_by_vim_instance')
    let g:screen_size_by_vim_instance = 1
  endif
  autocmd VimEnter *
        \ if g:screen_size_restore_pos == 1 |
        \   call ScreenRestore() |
        \ endif
  autocmd VimLeavePre *
        \ if g:screen_size_restore_pos == 1 |
        \   call ScreenSave() |
        \ endif
endif

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace //
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWritePre * :%s/\s\+$//e
if version >= 702
  autocmd BufWinLeave * call clearmatches()
endif

" Text formatting
set autoindent
set expandtab
set smartindent
set softtabstop=2
set shiftwidth=2
set tabstop=2
autocmd FileType c,cpp,java,mkd,markdown,python
      \ setlocal softtabstop=4 shiftwidth=4 tabstop=4
" Disable automatic comment insertion
autocmd FileType *
      \ setlocal formatoptions-=c formatoptions-=o

" Mappings
"noremap j gj
"noremap k gk
"noremap <Down> gj
"noremap <Up> gk
"noremap gj j
"noremap gk k
"noremap H ^
"noremap L $
"inoremap <C-A> <ESC>I
"inoremap <C-E> <ESC>A
"cnoremap <C-A> <Home>
"cnoremap <C-E> <End>
" Break the undo block when Ctrl-u
"inoremap <C-U> <C-G>u<C-U>

" Help
function SetHelpMapping()
  nnoremap <buffer> q :q<CR>
endfunction
autocmd FileType help call SetHelpMapping()
autocmd BufEnter *
      \ if winnr('$') == 1 &&
      \     getbufvar(winbufnr(winnr()), '&buftype') == 'help' |
      \   q |
      \ endif

" Quickfix
function SetQuickfixMapping()
  nnoremap <buffer> q :ccl<CR>
endfunction
autocmd FileType qf call SetQuickfixMapping()
autocmd BufEnter *
      \ if winnr('$') == 1 &&
      \     getbufvar(winbufnr(winnr()), '&buftype') == 'quickfix' |
      \   q |
      \ endif

" Search regex
nnoremap / /\v
vnoremap / /\v
cnoremap %s/ %smagic/
cnoremap \>s/ \>smagic/

" Auto close
"inoremap (<CR> (<CR>)<ESC>O
"inoremap [<CR> [<CR>]<ESC>O
"inoremap {<CR> {<CR>}<ESC>O

" Center display after searching
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" Reselect visual block after shifting
vnoremap < <gv
vnoremap > >gv

" Splitted windows
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l

" Tab
map <C-T> :tabnew<CR>
if has('win32')
  map <C-Tab> :tabnext<CR>
  map <C-S-Tab> :tabprevious<CR>
elseif has('unix')
  map t :tabnext<CR>
  map T :tabprevious<CR>
endif

" C, C++ compile & execute
autocmd FileType c,cpp map <F5> :w<CR>:make %<CR>
autocmd FileType c,cpp imap <F5> <ESC>:w<CR>:make %<CR>
autocmd FileType c
      \ if !filereadable('Makefile') && !filereadable('makefile') |
      \   setlocal makeprg=gcc\ -o\ %< |
      \ endif
autocmd FileType cpp
      \ if !filereadable('Makefile') && !filereadable('makefile') |
      \   setlocal makeprg=g++\ -o\ %< |
      \ endif
if has('win32')
  map <F6> :!%<.exe<CR>
  imap <F6> <ESC>:!%<.exe<CR>
elseif has('unix')
  map <F6> :!./%<<CR>
  imap <F6> <ESC>:!./%<<CR>
endif

" Python execute
autocmd FileType python map <F5> :w<CR>:!python %<CR>
autocmd FileType python imap <F5> <ESC>:w<CR>:!python %<CR>

" Ruby execute
autocmd FileType ruby map <F5> :w<CR>:!ruby %<CR>
autocmd FileType ruby imap <F5> <ESC>:w<CR>:!ruby %<CR>

" man page settings
autocmd FileType c,cpp set keywordprg=man
autocmd FileType ruby set keywordprg=ri

" Ruby configuration files view
autocmd BufNewFile,BufRead Gemfile,Guardfile setlocal filetype=ruby

" Gradle view
autocmd BufNewFile,BufRead *.gradle setlocal filetype=groovy

" Json view
autocmd BufNewFile,BufRead *.json setlocal filetype=json

" zsh-theme view
autocmd BufNewFile,BufRead *.zsh-theme setlocal filetype=zsh

" ANSI escape for Rails log
autocmd FileType railslog :AnsiEsc

" mobile.erb view
augroup rails_subtypes
  autocmd!
  autocmd BufNewFile,BufRead *.mobile.erb let b:eruby_subtype = 'html'
  autocmd BufNewFile,BufRead *.mobile.erb setfiletype eruby
augroup END

" PreserveNoEOL
let g:PreserveNoEOL = 1

" EasyMotion
let g:EasyMotion_leader_key = '<Leader>'

" Fugitive
let s:fugitive_insert = 0
augroup colorcolumn
  autocmd!
  autocmd FileType gitcommit
        \ if exists('+colorcolumn') |
        \   set colorcolumn=73 |
        \ else |
        \   let w:m2 = matchadd('ErrorMsg', '\%>72v.\+', -1) |
        \ endif
augroup END
autocmd FileType gitcommit
      \ if byte2line(2) == 2 |
      \   let s:fugitive_insert = 1 |
      \ endif
autocmd VimEnter *
      \ if (s:fugitive_insert) |
      \   startinsert |
      \ endif

"autocmd FileType gitcommit let s:open_nerdtree = 0
"autocmd FileType gitrebase let s:open_nerdtree = 0

" airline
let g:airline_left_sep = ''
let g:airline_right_sep = ''

" NERD Tree
"let s:open_nerdtree = 1
"if &diff
"  let s:open_nerdtree = 0
"endif
"autocmd VimEnter *
"      \ if (s:open_nerdtree) |
"      \   NERDTree |
"      \   wincmd p |
"      \ endif
"autocmd BufEnter *
"      \ if winnr('$') == 1 &&
"      \     exists('b:NERDTreeType') && b:NERDTreeType == 'primary' |
"      \   q |
"      \ endif
"autocmd VimEnter * if argc() == 0 | NERDTree | endif


" ConqueTerm
let g:ConqueTerm_InsertOnEnter = 1
let g:ConqueTerm_CWInsert = 1
let g:ConqueTerm_ReadUnfocused = 1
autocmd FileType conque_term highlight clear ExtraWhitespace
command -nargs=* Sh ConqueTerm <args>
command -nargs=* Shsp ConqueTermSplit <args>
command -nargs=* Shtab ConqueTermTab <args>
command -nargs=* Shvs ConqueTermVSplit <args>

" Adblock
let g:adblock_filter_auto_checksum = 1

" LaTeX-Suite-aka-Vim-LaTeX
let g:tex_flavor = 'latex'
if has('win32')
  set grepprg=findstr\ /n\ /s
elseif has('unix')
  set grepprg=grep\ -nH\ $*
endif
set iskeyword+=:
" Change default mappings for IMAP_Jumpfunc
if exists('g:Imap_StickyPlaceHolders') && g:Imap_StickyPlaceHolders
  vmap <C-Space> <Plug>IMAP_JumpForward
else
  vmap <C-Space> <Plug>IMAP_DeleteAndJumpForward
endif
imap <C-Space> <Plug>IMAP_JumpForward
nmap <C-Space> <Plug>IMAP_JumpForward

" Markdown Vim Mode
let g:vim_markdown_folding_disabled = 1

" Rake
nmap <Leader>ra :Rake<CR>

" RuboCop
let g:vimrubocop_keymap = 0
nmap <Leader>ru :RuboCop<CR>

" For some reason home and end keys are not mapping properly.
" Home key
imap <esc>OH <esc>0i
cmap <esc>OH <home>
nmap <esc>OH 0
" End key
nmap <esc>OF $
imap <esc>OF <esc>$a
cmap <esc>OF <end>

"set tw=80
"function WordWrap()
"  normal! gggqG
"endfunction
"nnoremap ; :call WordWrap()<CR>
"
