call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'lfv89/vim-interestingwords'

call plug#end()

set number
vmap <C-c> "+y
nmap <F6> :NERDTreeToggle<CR>
