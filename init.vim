set scrolloff=8
set number
set relativenumber
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set encoding=UTF-8
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

" setl commentstring=//%s
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
Plug 'junegunn/fzf', {'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'dracula/vim'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
" Added for closing Brakets
Plug 'Raimondi/delimitMate'
Plug 'vimlab/split-term.vim'
Plug 'sheerun/vim-polyglot',
Plug 'preservim/nerdcommenter'
Plug 'jparise/vim-graphql'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dbeniamine/cheat.sh-vim'
Plug 'tpope/vim-surround'
Plug 'Chiel92/vim-autoformat'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'svermeulen/vim-subversive'
" Neovim Tree shitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'ThePrimeagen/harpoon'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

source ~/.config/nvim/plug-config/coc/coc.vim

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

augroup highlight_yank
autocmd!
autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END
augroup Terminal
  " remap  pf :lua require('telescope.builtin').find_files()
    au!
    au TermOpen * let g:last_terminal_chan_id = b:terminal_job_id
augroup END
" set rtp+=/usr/local/homebrew/opt/fzf
if (has("termguicolors"))
  set termguicolors
endif
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
" nnoremap <leader>pv :Vex<CR>
" nnoremap <leader>pf :Files<CR>
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
nnoremap <silent> <Leader>aa :NERDTreeToggle<CR>

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


" nnoremap <C-j> <C-d>
" nnoremap <C-k> <C-u>
" vnoremap <C-j> <C-d>
" vnoremap <C-k> <C-u>
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
nnoremap <leader>B :bn<CR>
nnoremap <leader>b :bp<CR>

nnoremap <leader>r :!mv platformio.ini platformio2.ini<CR> :!mv platformio3.ini platformio.ini<CR> :!mv platformio2.ini platformio3.ini<CR><CR>

nnoremap Y y$

nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ'z



" Subsitute Plugin
" s for substitute
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)
nmap <leader>s <plug>(SubversiveSubstituteRange)
xmap <leader>s <plug>(SubversiveSubstituteRange)
nmap <leader>ss <plug>(SubversiveSubstituteWordRange)
" map <Leader>j :call ToggleFastMoveMode()<CR>
" map <Leader>k :call ToggleFastMoveMode()<CR>
" vmap <Leader>k :call ToggleFastMoveMode()<CR>gv
" vmap <Leader>j :call ToggleFastMoveMode()<CR>gv

let g:fastMoveMode = 0

" function! ToggleFastMoveMode()
" let g:fastMoveMode = 1 - g:fastMoveMode
" if (g:fastMoveMode == 0)
" noremap j j
" vnoremap j j
" noremap k k
" vnoremap k k
" else
" noremap j 10j
" vnoremap j 10j
" noremap k 10k
" vnoremap k 10k
" endif
" endfunction

nnoremap <PageUp> 10k
nnoremap <PageDown> 10j


imap ;; <ESC>A;<ESC>
nnoremap <A-right> <C-i> 
nnoremap <A-left> <C-o> 
nnoremap gf :e <cfile><cr>
