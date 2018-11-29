" Douglas Black
" Vim Plugins {{{
let $PATH = $PATH . ':' . expand('~/.vim/bundle')
execute pathogen#infect()
" }}}
" Colors {{{
syntax enable           " enable syntax processing
let g:solarized_termcolors=256
let g:solarized_contrast="high"
set background=dark
colorscheme solarized
set termguicolors
set t_Co=256
" }}}
" Misc {{{
set backspace=indent,eol,start
set clipboard=unnamed
" }}}
" Spaces & Tabs {{{
set tabstop=2           " The width of a hard tabstop measured in spaces 
set expandtab           " use spaces for tabs
set softtabstop=2       " Setting this to a non-zero value other than tabstop will make the tab key (in insert mode) insert a combination of spaces (and possibly tabs) to simulate tab stops at this width.
set shiftwidth=2	" The size of an indent
set modelines=1
filetype indent on	" load filetype-specific indent files
filetype plugin on
set autoindent
set smartindent
" }}}
" UI Layout {{{
set showmode		" show the vim mode (insert/command/visual)			
set number              " show line numbers
set showcmd             " show command in bottom bar
set nocursorline        " highlight current line
set wildmenu		" visual autocomplete for command menu
set lazyredraw		" redraw only when we need to.
set showmatch           " higlight matching parenthesis
set fillchars+=vert:┃
" }}}
" Searching {{{
set ignorecase          " ignore case when searching
set incsearch           " search as characters are entered
set hlsearch            " highlight all matches
" }}}
" Other Options {{{
set history=1000
set nocompatible	" turn off old-vi compat (enables vim - useful for vi -u)

" }}}
" Folding {{{
"=== folding ===
" set foldmethod=indent   " fold based on indent level
" set foldnestmax=3	" max 3 depth
" set foldenable          " don't fold files by default on open
" set foldlevelstart=10   " start with fold level of 1
" }}}
" Line Shortcuts {{{
" highlight last inserted text
nnoremap gV `[v`]
" }}}
" Leader Shortcuts {{{
let mapleader="/"
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>l :call <SID>ToggleNumber()<CR>
nnoremap <leader>c :SyntasticCheck<CR>:Errors<CR>
" }}}

" AutoGroups {{{
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md,*.rb :call <SID>StripTrailingWhitespaces()
    autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter *.md setlocal ft=markdown
augroup END
" }}}
" Backups {{{
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
" }}}
" Plugins options {{{
let g:ale_completion_enabled = 1
let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 1
let g:ale_fixers = {
  \   'javascript': ['prettier', 'eslint'],
  \}
let g:ale_linters = {
  \   'javascript': ['eslint'],
  \}

set rtp+=/usr/local/opt/fzf

let g:ycm_semantic_triggers = {'haskell' : ['.']}
" }}}
" Custom Functions {{{
function! <SID>ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunc
" }}}
