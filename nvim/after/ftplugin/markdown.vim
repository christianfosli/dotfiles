" Extends vim made ftplugin/markdown.vim

" Turn on spellcheck:
setlocal spell

" Hardwrap lines at 80 characters
set textwidth=80

" Format with prettier
setlocal formatprg=prettier\ --parser\ markdown
