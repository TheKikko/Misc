" ================================================================================
" some initial stuff
" ================================================================================

let mapleader = " "

set background=dark
syntax on

command! ResourceVimrc :source ~/.vimrc
nnoremap <C-R><C-V> :ResourceVimrc<cr>:syntax on<cr>

" ================================================================================
" plugins
" ================================================================================
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'morhetz/gruvbox'
Plug 'luochen1990/rainbow'
call plug#end()


" ================================================================================
" misc sets
" ================================================================================

set ruler
set showcmd
set wildmenu
set backspace=indent,eol,start
set whichwrap+=<,>,h,l
set confirm
set cmdheight=2
set lazyredraw
set incsearch 
set hlsearch
set magic
set ignorecase 
set smartcase
set number
set numberwidth=5
set laststatus=2
set shiftwidth=2
set autoindent
set expandtab
set tabstop=2
set wildmode=list:longest,list:full
set matchpairs+=<:>
set mouse=a
set nopaste
set splitbelow
set splitright

" ================================================================================
"  functions and related
" ================================================================================

nnoremap <leader>, :nohl<CR>

vnoremap <silent> * :<C-u>call VisualSelection('','')<CR>/<C-R>=@/<CR><CR>

function! VisualSelection(direction, extra_filter) range
 let l:saved = @"
 execute "normal! vgvy"

 let l:pattern = escape(@", "\\/.*'$^~[]")
 let l:pattern = substitute(l:pattern, "\n$", "", "")

 if a:direction == 'gv'
   call CmdLine("Ack '" . l:pattern . "' " )
 elseif a:direction == 'replace'
   call CmdLine("%s" . '/'. l:pattern . '/')
 endif

 let@/ = l:pattern
 let @" = l:saved_reg
endfunction

function! InsertTabWrapper() 
 let col = col('.') - 1
 if !col || getline('.')[col - 1] !~ '\k'
   return "\<Tab>"
 else
   return "\<C-p>"
 endif
endfunction

inoremap <Tab> <C-R>=InsertTabWrapper()<CR>
inoremap <S-Tab> <C-n>

augroup numbertoggle 
 autocmd! 
 autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if&nu && mode() != "i" | set rnu   | endif 
 autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if&nu                  | set nornu | endif 
augroup END

augroup noStartupFile
 autocmd! 
 autocmd VimEnter * if eval("@%") == "" | e ~/Documents/notes/todo.notes | endif 
augroup END
nnoremap <leader>to :e ~/Documents/notes/todo.notes<CR>

autocmd FileType notes set tw=80

" ================================================================================
" misc 
" ================================================================================

filetype plugin indent on
filetype plugin on

let g:rainbow_active = 1

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif 

nnoremap <leader>cd :cd <C-R>=expand('%:p:h') . "/"<CR>

map <leader>bd :Bclose<cr>:tabclose<cr>gT
map <leader>ba :bufdo bd<cr>
map <leader>bl :ls<cr>
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>
map <leader>br : checktime<cr>

map <leader>td :tabclose<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tN :tabnew<cr>


command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
  let l:curentBufNum = bufnr("%")
  let l:alternateBufNum = bufnr("#")
  
  if buflisted(l:alternateBufNum)
    buffer # 
  else
    bnext
  endif

  if bufnr("%") == l:currentBufNum
    new
  endif

  if buflisted(l:currentBufNum)
    execute("bdelete! ".l:currentBufNum)
  endif
endfunction






