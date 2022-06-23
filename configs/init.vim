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
Plug 'fredtux/sonokai'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'karb94/neoscroll.nvim'
Plug 'rust-lang/rust.vim'
Plug 'github/copilot.vim'


call plug#end()

" Remap leader
let mapleader = ' '

" Resize quicker
nnoremap <silent> <C-w>0 :exe "resize " . (winheight(0) * 5/4)<CR>
nnoremap <silent> <C-w>9 :exe "resize " . (winheight(0) * 4/5)<CR>

" Neoscroll
lua require('neoscroll').setup()

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

" Start neoterm in insert mode (1) or not (0)
let g:neoterm_autoinsert=1

" open terminal in bottom split
let g:neoterm_default_mod='belowright'

" terminal split size
let g:neoterm_size=20

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
let g:vimtex_view_method = 'zathura'
nmap <silent> <leader>t :VimtexCompile<CR>

" Neoformat
nmap <leader>l :Neoformat<CR>

" lspconfig
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'rust_analyzer', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsSnippetDirectories=["UltiSnips"]

" Rust filetype config
syntax enable
filetype plugin indent on

" Copilot disable
au Vimenter * :Copilot disable

" Misc
nmap <C-n> :Tnew<cr>
nmap <C-s> :vertical Tnew <cr><Esc>60<C-w>><cr><Esc>i
inoremap { {<CR>}<Esc>ko
set number relativenumber
:set nu rnu
vmap <C-c> "+y
nmap <silent> <F6> :NERDTreeToggle<CR>
set splitbelow
set cursorline
set showcmd
set splitright
