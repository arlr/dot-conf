
" Remove compatibility with vi
set nocompatible

" Syntax highlight on
syntax on

" Display line number
set number

" Detect file type
filetype on
"" Load plugins according to the file type
filetype plugin on

" Highlight the cursor line
set cursorline

"Shift width
set shiftwidth=4

" Tabs size
set tabstop=4

" No backup save
set nobackup

" Search in file
"" Ignore case when search
set ignorecase
""" If we set a capital letter in our search this will make it case sensitive
set smartcase
"" Highlight matching char as we type the search
set incsearch
"" Show matching word during the search
set showmatch
"" Highlight during the search
set hlsearch


