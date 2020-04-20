let g:solarized_termcolors=256

let mapleader = ","

" ----------------------------------------------
" Setup basic Vim behaviour
" ----------------------------------------------

syntax on

set number                " Line numbers
set scrolloff=3           " More context around cursor
set shiftwidth=2          " Number of spaces to autoformat tabs to
set wildmode=list:longest " Shell-like behaviour for command autocompletion

" Search options
set ignorecase
set smartcase

let g:ackprg = 'ag --nogroup --nocolor --column'
noremap <Leader>a :Ack! -w <cword><cr>

" ----------------------------------------------
" Command Shortcuts
" ----------------------------------------------

" make Y consistent with C and D
nnoremap Y y$

" ,c to show hidden characters
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>c :set nolist!<CR>

" ,sw to strip whitespace off the ends
nmap <silent> <Leader>sw :call StripTrailingWhitespace()<CR>

" Ignores files in any VCS or tmp directory
set wildignore+=tmp/*,*.so,*.swp,*.zip

" F5 to reload doc
map <silent> <F5> <esc>:e %<CR>

" ----------------------------------------------
" Setup Misc Vim Behaviours
" ----------------------------------------------

" Jump to last cursor position when opening a file
" Don't do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
  if &filetype !~ 'commit\c'
    if line("'\"") > 0 && line("'\"") <= line("$")
      exe "normal g`\""
    endif
  end
endfunction

" ----------------------------------------------
"  Set the git gutter colors to be the same as the number column
" ----------------------------------------------
hi clear SignColumn

"-" ,] to toggle the tags sidebar
"-nmap <Leader>] :TagbarToggle<CR>
" Set the Gutter to show all the time, avoiding the column 'pop' when saving
set signcolumn=yes

let &t_Co=256
set shell=/bin/zsh

set noswapfile

set rtp+=/usr/local/opt/fzf
nnoremap <leader>f :FZF<CR>

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'relativepath', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ], [ 'fileformat' ] ]
      \ },
      \ 'inactive': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'relativepath', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ], [ 'fileformat' ] ]
      \ },
      \ }

set hidden

let g:LanguageClient_serverCommands = {
    \ 'go': ['/Users/haydenfaulds/go/bin/gopls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'typescript': ['javascript-typescript-stdio'],
    \ 'ruby': ['/usr/local/bin/solargraph', 'stdio'],
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ }

command!          Definition     call LanguageClient#textDocument_definition()
command!          TypeDefinition call LanguageClient#textDocument_typeDefinition()
command! -nargs=1 Rename         call LanguageClient#textDocument_rename({'newName': <f-args>})
command!          Format         call LanguageClient#textDocument_formatting()
command!          References     call LanguageClient#textDocument_references()
