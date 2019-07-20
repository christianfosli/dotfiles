" File: init.vim
" Maintainer: Christian Fosli <cfosli@gmail.com>

" General
set ignorecase  	" Case insensitive search
set smartcase		"  - except when searching with upper-case characters
set autowrite		" Automatically write before :make, :!, :bn, etc
set laststatus=1	" Show statusline only when there are at least 2 windows
let g:mapleader=' '	" Use <space> as leader key

" Colors - use default colorscheme but make comments gray
highlight comment ctermfg=gray

" Auto-close {<cr>
inoremap {<cr> {<cr>}<C-c>O

" Use 4-spaces instead of tab (for tab char use <C-V><tab>)
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab

" Spell checker
nnoremap <leader>s :setlocal spell!<cr>
set spelllang=en,nb

" Generate .spl binary file if this file is outdated or doesn't exist
if (has('unix'))
        let g:spellAdd = $HOME . '/.vim/spell/en.utf-8.add'
elseif has('win32')
        let g:spellAdd = $HOME . '/vimfiles/spell/en.utf-8.add'
endif
if (! filereadable(g:spellAdd . '.spl')
            \|| getftime(g:spellAdd) > getftime(g:spellAdd . '.spl'))
        execute 'mkspell! ' . fnameescape(g:spellAdd)
endif

" Read aliases when running shell commands
let $BASH_ENV = '~/.bash_aliases'

" Copy to clipboard for WSL!
if has('unix') && executable('clip.exe')
        packadd! wsl-copy
endif
nmap <silent> <leader>y <Plug>WslCopy
xmap <silent> <leader>y <Plug>WslCopy

" Make (Set makeprg in after/ftplugin)
if findfile('Makefile') ==# 'Makefile' || findfile('gradlew') ==# 'gradlew'
        nnoremap <buffer> <leader>m :silent !clear<cr>:make!<cr>
else
        nnoremap <buffer> <leader>m :silent !clear<cr>:make! %<cr>
endif
" Run (Override in after/ftplugin) target bott tmux pane for programming
nnoremap <buffer> <leader>r :! see %<cr>
" Build in bottom tmux pane (Override in after/ftplugin)
nnoremap <buffer> <leader>b :! tmux send-keys -t bottom "make" Enter<cr><cr>
