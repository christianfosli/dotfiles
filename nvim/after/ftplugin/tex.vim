" Tex specific cmds! Extends built in /ftplugin/tex.vim

" set tex flavor to latex
let g:tex_flavor = 'latex'

" Turn on spellcheck:
setlocal spell

" View pdf
if !empty(glob("%:r.pdf"))
	nnoremap <buffer> <leader>r :silent ! see %:r.pdf<CR><C-l>
else
	nnoremap <buffer> <leader>r :silent ! see main.pdf<CR><C-l>
endif

" Lint with chktex
setlocal makeprg=chktex

" Run neomake on save
call neomake#configure#automake('w')

" Build pdf in tmux bottom pane
if findfile('Makefile')!=#('MakeFile')
    nnoremap <buffer> <leader>b :!tmux send-keys -t bottom "pdflatex %" Enter<cr><cr>
endif
