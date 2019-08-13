" Tex specific cmds! Extends built in /ftplugin/tex.vim

" Set make (tex compiler looks for Makefile and sets up accordingly):
let g:tex_flavor = 'pdflatex'
compiler tex

" cd to files dir, to output .pdf file in same dir
cd %:h

" Turn on spellcheck:
setlocal spell

" View pdf
nnoremap <buffer> <leader>r :silent ! see %:r.pdf<CR><C-l>

" Build pdf in tmux bottom pane
if findfile('Makefile')!=#('MakeFile')
    nnoremap <buffer> <leader>b :!tmux send-keys -t bottom "pdflatex %" Enter<cr><cr>
endif
