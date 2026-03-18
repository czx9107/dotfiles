set number             
set relativenumber    
set syntax=on        
set cursorline      

set tabstop=4      
set shiftwidth=4  
set expandtab    
set autoindent  

set hlsearch  
set incsearch  
set ignorecase
set smartcase
nnoremap <esc><esc> :noh<return><esc>

set nocompatible
set shortmess+=I
set number
set relativenumber

set laststatus=2
set backspace=indent,eol,start
set hidden
set ignorecase
set smartcase
nmap Q <Nop>
set noerrorbells visualbell t_vb=
set mouse+=a
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>

if has('nvim')
    inoremap <Left>  <ESC>:echoe "Use h"<CR>
    inoremap <Right> <ESC>:echoe "Use l"<CR>
    inoremap <Up>    <ESC>:echoe "Use k"<CR>
    inoremap <Down>  <ESC>:echoe "Use j"<CR>

    set clipboard=unnamedplus
    " let yank command to use system clipboard"

    if has('wsl')
        let g:clipboard = {
              \   'name': 'WslClipboard',
              \   'copy': {
              \      '+': '/mnt/c/Windows/System32/clip.exe',
              \      '*': '/mnt/c/Windows/System32/clip.exe',
              \    },
              \   'paste': {
              \      '+': '/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw))',
              \      '*': '/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw))',
              \   },
              \   'cache_enabled': 0,
              \ }
    endif
else
    set clipboard=
    set encoding=utf-8
endif
