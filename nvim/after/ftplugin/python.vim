" Python specific commands // extends vim included /ftplugin/python.vim

" Set make/makeprg  -  Not yet tested with a Makefile! :
if findfile('Makefile')!=#('MakeFile')
	" Set compiler
	let b:compiler='pyunit'
	" Set makeprg:
	setlocal makeprg=python3
	" Set errorformat (ref vim.wikia.com)
	setlocal errorformat=%C\ %.%#,A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
        " Build in tmux bottom pane
        nnoremap <buffer> <leader>b :!tmux send-keys -t bottom "python3 %" Enter<cr><cr>
endif

" Fix run mapping:
nnoremap <buffer> <leader>r :!tmux send-keys -t bottom "python3 %" Enter<cr><cr>
