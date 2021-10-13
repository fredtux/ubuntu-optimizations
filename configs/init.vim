call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'lfv89/vim-interestingwords'
Plug 'kassio/neoterm'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'sbdchd/neoformat'
Plug 'bfrg/vim-cpp-modern'
Plug 'sainnhe/sonokai'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" Remap leader
let mapleader = ' '

" Color scheme
" Important!!
if has('termguicolors')
    set termguicolors
endif
" The configuration options should be placed before `colorscheme sonokai`.
let g:sonokai_style = 'andromeda'
let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 1

colorscheme sonokai

" Airline
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

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Dap debug adapter
lua << EOF
local dap = require('dap')
dap.adapters.python = {
    type = 'executable';
    command = '/usr/bin/python3';
    args = { '-m', 'debugpy.adapter' };
}
EOF

lua << EOF
local dap = require('dap')
dap.configurations.python = {
  {
    type = 'python';
    request = 'launch';
    name = "Launch file";
    program = "${file}";
    pythonPath = function()
      return '/usr/bin/python3'
    end;
  },
}
EOF

lua << EOF
require('dap')
vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
EOF

" Dap shortcuts
nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>

" Dap UI settings
nmap <silent> <leader>i :lua require("dapui").setup()<CR>
nmap <silent> <C-i> :lua require("dapui").toggle()<CR>

" Vimtex settings
let g:tex_flavor = 'latex'
nmap <silent> <leader>t :VimtexCompile<CR>

" Neoformat
nmap <leader>l :Neoformat<CR>

" Misc
nmap <C-n> :Topen<cr>
set number
vmap <C-c> "+y
nmap <silent> <F6> :NERDTreeToggle<CR>
set splitbelow
