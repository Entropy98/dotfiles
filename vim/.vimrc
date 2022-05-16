"language specific
au BufRead,BufNewFile *.S set filetype=asm

set nocompatible  "Kill vi-compatibility
set t_Co=256 "256 color
set encoding=utf-8 "UTF-8 character encoding

" Indent 2 spaces
set tabstop=2  "2 space tabs
set shiftwidth=2  "2 space shift
set softtabstop=2  "Tab spaces in no hard tab mode
set expandtab  " Expand tabs into spaces
set autoindent  "autoindent on new lines

set showmatch  "Highlight matching braces

set ruler  "Show bottom ruler
set cursorline

set equalalways  "Split windows equal size

set formatoptions=croq  "Enable comment line auto formatting

set title  "Set window title to file
set hlsearch  "Highlight on search
set ignorecase  "Search ignoring case
set smartcase  "Search using smartcase
set incsearch  "Start searching immediately

set scrolloff=5  "Never scroll off
set wildmode=longest,list  "Better unix-like tab completion
set clipboard=unnamed  "Copy and paste from system clipboard
set lazyredraw  "Don't redraw while running macros (faster)
set wrap  "Visually wrap lines
set linebreak  "Only wrap on 'good' characters for wrapping
set backspace=indent,eol,start  "Better backspacing
set linebreak  "Intelligently wrap long files
set ttyfast  "Speed up vim
set nostartofline "Vertical movement preserves horizontal position

" Strip whitespace from end of lines when writing file
autocmd BufWritePre * :%s/\s\+$//e

" Syntax highlighting and stuff
syntax on
filetype plugin indent on

set number
set relativenumber

nnoremap <C-down> <C-W><C-J>
nnoremap <C-up> <C-W><C-K>
nnoremap <C-right> <C-W><C-L>
nnoremap <C-left> <C-W><C-H>

" Refresh CScope
map <F5> :!cscope -Rb<CR>:cs reset<CR><CR>

execute pathogen#infect()
autocmd VimEnter * NERDTree | wincmd p
"Turn on coloring on startup
"autocmd VimEnter * ColorToggle

" Vim-Plug
call plug#begin('~/.local/share/nvim/site/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()
