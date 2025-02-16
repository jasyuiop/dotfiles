" --- SETTINGS ---

set nocompatible

syntax on
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smarttab
set smartindent
set guicursor=
set t_vb=
set nu
set ruler
set nowrap
set smartcase
set noswapfile
set nowritebackup
set nobackup
set incsearch
set hlsearch
nohlsearch
set relativenumber
set autoindent
set signcolumn=no
set hidden
set showmode
set showcmd
set noshowmatch
set ttyscroll=3
set ttymouse=xterm2
set mouse=a
set autoread
set backspace=indent,eol,start
set splitright
set splitbelow
set autowrite
set fileformats=unix,dos,mac
set pumheight=8
set ttyfast
set history=300
set wildmenu
set wildmode=list:longest,full
set wildignorecase
set path+=**
set updatetime=300
set encoding=utf-8
set viminfo='20,<1000,s1000
set scrolloff=999
set shortmess+=I
set completeopt=menu,menuone

if v:version >= 800
  set nofixendofline
  set foldmethod=manual
  set nofoldenable
endif

filetype plugin indent on

" Leader key
let mapleader = ","

" Define a list of patterns to ignore for file and directory
" command-line completion
set wildignore=*~,#*#,*.7z,.DS_Store,.git,.hg,.svn,*.a,*.adf,*.asc,*.au,*.aup
      \,*.avi,*.bin,*.bmp,*.bz2,*.class,*.db,*.dbm,*.djvu,*.docx,*.exe
      \,*.filepart,*.flac,*.gd2,*.gif,*.gifv,*.gmo,*.gpg,*.gz,*.hdf,*.ico
      \,*.iso,*.jar,*.jpeg,*.jpg,*.m4a,*.mid,*.mp3,*.mp4,*.o,*.odp,*.ods,*.odt
      \,*.ogg,*.ogv,*.opus,*.pbm,*.pdf,*.png,*.ppt,*.psd,*.pyc,*.rar,*.rm
      \,*.s3m,*.sdbm,*.sqlite,*.swf,*.swp,*.tar,*.tga,*.ttf,*.wav,*.webm,*.xbm
      \,*.xcf,*.xls,*.xlsx,*.xpm,*.xz,*.zip

" Enough for line numbers + gutter within 80 standard (gq reformat)
set textwidth=72

" Ruler formating
set ruf=%40(%=%#LineNr#%.50F\ \[%{strlen(&ft)?&ft:'none'}]\ %l:%c\ %p%%%)

" Clipboard integration
set clipboard^=unnamed
set clipboard^=unnamedplus

" Undofiles
if has('persistent_undo')
  set undofile
  set undodir=~/.cache/vim
endif

" Netrw
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_altv=1
let g:netrw_list_hide=netrw_gitignore#Hide()

" Start at last place you were editing
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Filetypes related settings
autocmd FileType yaml setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType json setlocal expandtab shiftwidth=2 tabstop=2
autocmd BufNewFile,BufRead *.sh setlocal expandtab shiftwidth=2 tabstop=2
autocmd BufNewFile,BufRead *.vim setlocal expandtab shiftwidth=2 tabstop=2
autocmd BufNewFile,BufRead *.txt setlocal noet ts=4 sw=4
autocmd BufNewFile,BufRead *.html setlocal noet ts=2 sw=2
autocmd BufNewFile,BufRead *.js setlocal noet ts=4 sw=4
autocmd BufNewFile,BufRead *.css setlocal noet ts=2 sw=2

" Mark trailing spaces as errors
match IncSearch '\s\+$'

" Use ripgrep
if executable('rg')
    set grepprg=rg\ -S\ --vimgrep grepformat=%f:%l:%c:%m
    autocmd QuickFixCmdPost *grep* cwindow
endif

" --- Keybinds ---

" Fast save
nnoremap <leader>w :w!<cr>

" Disable search highlighting visual, normal and insert mode
nnoremap <C-L> :nohlsearch<CR><C-L>
inoremap <C-L> <C-O>:execute "normal \<C-L>"<CR>
vmap <C-L> <Esc><C-L>gv

" Leader h toggles highlighting search results
nnoremap <leader>h :set hlsearch! hlsearch?<CR>

" Backslash invokes grep
nnoremap \ :grep<SPACE>

" Leader ff invokes find
nnoremap <leader>ff :find<SPACE>

" Location list
nnoremap <leader>l :lopen<CR>

" Close quickfix window
nnoremap <leader>c :cclose<CR>

" Center the cursor when moving up and down
noremap <C-d> <C-d>zz
noremap <C-u> <C-u>zz

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Print full path
map <C-f> :echo expand("%:p")<cr>

" Exit on jj and jk
imap jk <Esc>
imap jj <Esc>

" Act like D and C
nnoremap Y y$

" Do not show stupid q: window
map q: :q

" Disable ex mode keybind
nnoremap Q <nop>

" Cursor jumps around while joining lines, this fix the situation
nnoremap J mzJ`z

" Move entire line up and down
vnoremap <C-S-J> :m'>+<CR>gv=gv
vnoremap <C-S-K> :m-2<CR>gv=gv

" Leader j jumps to buffers
nnoremap <Leader>j :buffers<CR>:buffer<Space>

" Leader d deletes the current buffer
nnoremap <Leader>d :bdelete<CR>

" Function keys
map <F1> :set number!<CR> :set relativenumber!<CR>

" --- Plugins ---

if filereadable(expand("~/.vim/autoload/plug.vim"))

  call plug#begin()
  Plug 'tpope/vim-commentary'
  Plug 'conradirwin/vim-bracketed-paste'
  Plug 'morhetz/gruvbox'
  Plug 'dense-analysis/ale'
  Plug 'ervandew/supertab'
  call plug#end()

  " Color settings
  autocmd vimenter * ++nested colorscheme gruvbox
  set background=dark
  set termguicolors
  let g:gruvbox_contrast_dark = "hard"
  let g:gruvbox_contrast_light = "hard"

  " Supertab
  let g:SuperTabDefaultCompletionType = "context"
  let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']

  " Ale
  let g:ale_disable_lsp = 1
  let g:ale_lint_on_text_changed = 'never'
  let g:ale_virtualtext_cursor = 'disabled'
  let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
  let g:ale_fix_on_save = 1
  let g:ale_linters = {
        \ 'sh': ['shellcheck']
        \}
  let g:ale_fixers = {
        \ '*': ['remove_trailing_lines', 'trim_whitespace'],
        \ 'sh': ['shfmt']
        \}
else
  autocmd vimleavepre *.sh !shfmt -w %
endif
