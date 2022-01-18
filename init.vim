set scrolloff=8
set number
set relativenumber
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set encoding=utf8
set exrc
set nohlsearch
set hidden
set noerrorbells
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
setl commentstring=//%s
set smartindent
" set g:airline_powerline_fonts = 1
set list
" set listchars=tab:>\trail:--

call plug#begin("~/.vim/plugged")
Plug 'tpope/vim-capslock'
Plug 'easymotion/vim-easymotion'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'
Plug 'Tpope/vim-commentary'
Plug 'gruvbox-community/gruvbox'
if exists('g:vscode')
    " VSCode extension

else
    " ordinary neovim
" Plug 'junegunn/fzf', {'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
Plug 'pangloss/vim-javascript'
Plug 'peitalin/vim-jsx-typescript'
Plug 'leafgarland/typescript-vim'
Plug 'dracula/vim'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
" Added for closing Brakets
Plug 'Raimondi/delimitMate'
Plug 'vim-scripts/cpp_doxygen'
" geht nicht
" let g:load_doxygen_syntax=1
" nnoremap <leader>d <Plug>cpp_doxygenInsert
Plug 'vimlab/split-term.vim'
" Neovim Tree shitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
" telescope requirements...
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
" Plug 'hrsh7th/nvim-cmp'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
" Plug 'hrsh7th/cmp-nvim-lsp'
" Plug 'hrsh7th/cmp-buffer'
" Plug 'hrsh7th/nvim-cmp'
Plug 'ThePrimeagen/harpoon'
" For vsnip user.
" Plug 'hrsh7th/cmp-vsnip'
" Plug 'hrsh7th/vim-vsnip'
" Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
" let g:coc_global_extensions = ['coc-tsserver',
" \'coc-python',
" \ 'coc-pydocstring',
" \ 'coc-json',
" \ 'coc-html-css-support',
" \ 'coc-css',
" \ 'coc-sql',
" \ 'coc-yaml']
" Plug 'sheerun/vim-polyglot',
Plug 'preservim/nerdcommenter'
Plug 'jparise/vim-graphql'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" post install wasaaaaaaaaaaaa(yarn install | npm install) then load plugin only for editing supported files
" Plug 'wasaaaaaaaaaaaaprettier/vim-prettier', {
" \ 'wasaaaaaaaaaaaado': 'yarn install',
" \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
Plug 'dbeniamine/cheat.sh-vim'
Plug 'Chiel92/vim-autoformat'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
" Plug 'gbprod/substitute.nvim'
Plug 'svermeulen/vim-subversive'

call plug#end()


" lua <<EOF
"   -- Setup nvim-cmp.
"   local cmp = require'cmp'

"   cmp.setup({
"     snippet = {
"       expand = function(args)
"         -- For `vsnip` user.
"         vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.

"         -- For `luasnip` user.
"         -- require('luasnip').lsp_expand(args.body)

"         -- For `ultisnips` user.
"         -- vim.fn["UltiSnips#Anon"](args.body)
"       end,
"     },
"     mapping = {
"       ['<C-d>'] = cmp.mapping.scroll_docs(-4),
"       ['<C-f>'] = cmp.mapping.scroll_docs(4),
"       ['<C-n>'] = cmp.mapping.complete(),
"       ['<C-e>'] = cmp.mapping.close(),
"       ['<CR>'] = cmp.mapping.confirm({ select = true }),
"     },
"     sources = {
"       { name = 'nvim_lsp' },

"       -- For vsnip user.
"       { name = 'vsnip' },

"       -- For luasnip user.
"       -- { name = 'luasnip' },

"       -- For ultisnips user.
"       -- { name = 'ultisnips' },

"       { name = 'buffer' },
"     }
"   })

"   -- Setup lspconfig.
"   require('lspconfig').ccls.setup {
"     capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
"   }
" EOF
" lua << EOF
" require'lspconfig'.ccls.setup{}
" EOF
" 
" ---------------------------------------------------
" ----------- LSP CONFIG ------
"  --------------------------------------------------
"
lua require'lspconfig'.ccls.setup{on_attach=require'completion'.on_attach}
set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact','substring','fuzzy']
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
local servers = { 'pyright',  'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF
lua << EOF
vim.lsp.set_log_level("debug")
EOF

" if (has("termguicolors"))
"   set termguicolors
" endif
syntax enable
colorscheme gruvbox
" highlight Normal guibg=none
" colorscheme dracula

set colorcolumn=80
set signcolumn=yes

" One mapping that I love to use is jk. I use jk to automatically escape, save, and then return when I'm in insert mode. I've found it to be a very useful little shortcut. The other shortcuts are for searching files and such.
" The pv map opens up a new tab to the side.
" The pf map opens up a finder that we can use for quickly searching.
" The Ctrl-P map is for searching for files within a Git repository. This is useful for finding files inside your software project.
let mapleader = " "
nnoremap <leader>pv :Vex<CR>
nnoremap <leader>pf :Files<CR>
inoremap jk <esc>:w<CR>
nnoremap <C-p> :GFiles<CR>
" imap <Esc> <Plug>CapsLockToggle
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 0
let g:NERDTreeIgnore = ['node_modules']
let NERDTreeStatusLine='NERDTree'
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" " Toggle
nnoremap <silent> <C-a> :NERDTreeToggle<CR>
 
set splitright  

set splitbelow  
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
tnoremap <C-k> <C-\><C-n>
nnoremap n nzzzv" " start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" " open terminal on ctrl+n
function! OpenTerminal()
    split term:Term
    resize 10   
endfunction     
nnoremap <Leader>n :8Term <CR>
let g:prettier#autoformat_config_present = 1
let g:prettier#config#config_precedence = 'prefer-file'
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>= :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
        
nnoremap <silent> <Leader>v+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>v= :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>v- :exe "resize " . (winheight(0) * 2/3)<CR>
         
tnoremap <M-h> <C-\><C-N><C-w>h    
tnoremap <M-j> <C-\><C-N><C-w>j    
tnoremap <M-k> <C-\><C-N><C-w>k    
tnoremap <M-l> <C-\><C-N><C-w>l    
inoremap <M-h> <C-\><C-N><C-w>h    
inoremap <M-j> <C-\><C-N><C-w>j    
inoremap <M-k> <C-\><C-N><C-w>k    
inoremap <M-l> <C-\><C-N><C-w>l     
nnoremap <M-h> <C-w>h     
nnoremap <M-j> <C-w>j    
nnoremap <M-k> <C-w>k    
nnoremap <M-l> <C-w>l    
tnoremap <Esc> <C-\><C-n>     
   
   
tnoremap <M-Left> <C-\><C-N><C-w>h 
tnoremap <M-Down> <C-\><C-N><C-w>j  
tnoremap <M-Up> <C-\><C-N><C-w>k 
tnoremap <M-Right> <C-\><C-N><C-w>l 
inoremap <M-Left> <C-\><C-N><C-w>h 
inoremap <M-Down> <C-\><C-N><C-w>j
inoremap <M-Up> <C-\><C-N><C-w>k
inoremap <M-Right> <C-\><C-N><C-w>l
nnoremap <M-Left> <C-w>h
nnoremap <M-Down> <C-w>j
nnoremap <M-Up> <C-w>k
nnoremap <M-Right> <C-w>l
nnoremap <M-Left> <C-w>h
nnoremap <M-Down> <C-w>j
nnoremap <M-Up> <C-w>k
nnoremap <M-Right> <C-w>l

" To update the init.vim press sv
nnoremap <leader>sv :w<bar><CR>:source $MYVIMRC<CR>
nnoremap <leader>sc :e $MYVIMRC<CR>

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>

nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>

nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap n nzzzvnnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap n nzzzvnnoremap <Leader>pf :lua require('telescope.builtin').find_files()<CR>


" https://github.com/ThePrimeagen/.dotfiles/blob/ca41b9e81a131cc0ac414d26d6703b5c21fd143a/nvim/.config/nvim/plugin/telescope.vim
nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>
" nnoremap <leader>vrc :lua require('theprimeagen.telescope').search_dotfiles()<CR>
" nnoremap <leader>va :lua require('theprimeagen.telescope').anime_selector()<CR>
" nnoremap <leader>vc :lua require('theprimeagen.telescope').chat_selector()<CR>
" nnoremap <leader>gc :lua require('theprimeagen.telescope').git_branches()<CR>
nnoremap <leader>gw :lua require('telescope').extensions.git_worktree.git_worktrees()<CR>
nnoremap <leader>gm :lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>
inoremap <C-j> ciw<C-r>0<ESC>
noremap <leader>a :Autoformat<CR>

" Motion for "next object". For example, "din(" would go to the next "()" pair
" and delete its contents.
onoremap an :<c-u>call <SID>NextTextObject('a')<CR>
xnoremap an :<c-u>call <SID>NextTextObject('a')<CR>
onoremap in :<c-u>call <SID>NextTextObject('i')<CR>
xnoremap in :<c-u>call <SID>NextTextObject('i')<CR>

function! s:NextTextObject(motion)
  echo
  let c = nr2char(getchar())
  exe "normal! f".c."v".a:motion.c
endfunction


nnoremap ga <c-^>


nnoremap <C-j> <C-d>
nnoremap <C-k> <C-u>
vnoremap <C-j> <C-d>
vnoremap <C-k> <C-u>
"tnoremap <C-j> <C-d>
"tnoremap <C-k> <ESC>
"
" Change Comment String for Cpp
autocmd FileType c,cpp,java setl commentstring=//\ %s
" autocmd FileType lua setl commentstring="\ %s

" VisualBlock eddits
command! Visual      normal! v
command! VisualLine  normal! V
command! VisualBlock execute "normal! \<C-v>"
noremap <leader>vb :VisualBlock<CR>
     
       
" Open New Line and close it 
nnoremap <leader>o o<ESC>
nnoremap <leader>O O<ESC>
" make CR act like in insert mode
nnoremap <CR> i<CR><ESC>

" inoremap <S-DEL> <BACKSPACE>
"
" remember the chan id (buffer id) of the last terminal buffer
"
augroup Terminal
  au!
  au TermOpen * let g:last_terminal_chan_id = b:terminal_job_id
augroup END
command! MakeinTerm call chansend(g:last_terminal_chan_id, "make<cr>")
command! InitPlatformio call chansend(g:last_terminal_chan_id, "platformio init --ide vim<cr>")
nnoremap <leader>mr :MakeinTerm<CR>
nnoremap <leader>mi :InitPlatformio<CR>
" Make for Platformio
" nnoremap <leader>mr :wa<bar><CR>:8Term make<CR>
nnoremap <leader>mu :wa<bar><CR>:8Term make upload<CR>
" nnoremap <leader>m <CR>:8Term pio run --target monitor<CR>

"Special Copy Command 
" nnoremap <C-c> "cyiw<CR>
" nnoremap <C-v> "cp<CR>
set rtp+=/usr/local/homebrew/opt/fzf 
nnoremap <leader>B :bn<CR>
nnoremap <leader>b :bp<CR>
" HARPOON Config
nnoremap <leader>1 :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <leader>2 :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <leader>3 :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <leader>4 :lua require("harpoon.ui").nav_file(4)<CR>
nnoremap <leader>5 :lua require("harpoon.ui").nav_file(5)<CR>
nnoremap <leader>6 :lua require("harpoon.ui").nav_file(6)<CR>
nnoremap <leader>7 :lua require("harpoon.ui").nav_file(7)<CR>
nnoremap <leader>8 :lua require("harpoon.ui").nav_file(8)<CR>
nnoremap <leader>fa :lua require("harpoon.mark").add_file()<CR>
nnoremap <leader>fr :lua require("harpoon.ui").toggle_quick_menu()<CR>

nnoremap <leader>r :!mv platformio.ini platformio2.ini<CR> :!mv platformio3.ini platformio.ini<CR> :!mv platformio2.ini platformio3.ini<CR><CR>

nnoremap Y y$

nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ'z

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END


" Subsitute Plugin
" s for substitute
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)
nmap <leader>s <plug>(SubversiveSubstituteRange)
xmap <leader>s <plug>(SubversiveSubstituteRange)
nmap <leader>ss <plug>(SubversiveSubstituteWordRange)
endif
