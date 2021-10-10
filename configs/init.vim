call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'lfv89/vim-interestingwords'
Plug 'kassio/neoterm'
Plug 'shaunsingh/nord.nvim'
Plug 'donRaphaco/neotex', { 'for': 'tex' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

colorscheme nord

set number
vmap <C-c> "+y
nmap <F6> :NERDTreeToggle<CR>
set splitbelow

let g:airline_powerline_fonts = 1

" Neoterm specific stuff
" Exit terminal mode (to normal mode) with esc
tnoremap <Esc> <C-\><C-n>

" Start neoterm in insert mode
let g:neoterm_autoinsert=1

" open terminal in bottom split
let g:neoterm_default_mod='belowright'

" terminal split size
let g:neoterm_size=16

" scroll to the bottom when running a command
let g:neoterm_autoscroll=1
nmap <C-n> :Topen<cr>
