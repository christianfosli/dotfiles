" Golang

" Go fmt specifies to use tabs iso spaces
setlocal noexpandtab
setlocal tabstop=4

" Enable coc.nvim
packadd coc.nvim-release

" Format on save
augroup goAuto
    autocmd!
    autocmd BufWritePre *.go call CocAction('format')
augroup END
