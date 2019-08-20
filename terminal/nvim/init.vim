call plug#begin()

" Utilities
Plug 'scrooloose/nerdtree'                " File explorer
Plug 'Xuyuanp/nerdtree-git-plugin'        " NERDTree git file status
Plug 'scrooloose/nerdcommenter'           " Commenting utilities
Plug 'airblade/vim-gitgutter'             " Git gutter
Plug 'haya14busa/incsearch.vim'           " Improved search
Plug 'haya14busa/incsearch-fuzzy.vim'     " Fuzzy searching
Plug 'tpope/vim-obsession'                " Session saving

" Display
Plug 'ryanoasis/vim-devicons'             " Icon set for utilities
Plug 'vim-airline/vim-airline'            " Status bar
Plug 'kshenoy/vim-signature'              " Gutter marks
Plug 'jeffkreeftmeijer/vim-numbertoggle'  " Line number toggling utility

" Syntax
Plug 'jiangmiao/auto-pairs'               " Auto punctuation pairs
Plug 'tpope/vim-surround'                 " Keymaps surrounding pairs
Plug 'pangloss/vim-javascript'            " Javascript syntax highlighting
Plug 'vim-syntastic/syntastic'            " Syntax checking

" Colors
Plug 'altercation/vim-colors-solarized'
Plug 'mhartington/oceanic-next'
Plug 'scwood/vim-hybrid'
Plug 'vim-airline/vim-airline-themes'
Plug 'trusktr/seti.vim'

call plug#end()

" Display settings
set rnu                                   " Relative line numbers on startup
set hls                                   " Search highlight
set cursorline                            " Highlight current line
set ruler                                 " Row and column counters
set expandtab                             " Spaces instead of tabs
set showcmd                               " Show commands being used
set winminheight=0                        " Show no lines of collapsed win

" Behaviour settings
set updatetime=250                        " Time delay for gui updates
set splitbelow                            " Cursor moves down on hsp
set splitright                            " Cursor moves right on vsp
set mouse=a                               " Mouse scrolls viewport instead of lines

" Color settings
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=dark
colorscheme seti
hi CursorLine cterm=NONE guibg=#391414    " Highlight line colors
hi OverLength cterm=NONE guibg=#802b2b guifg=#eeeeee " Overlength colors
match OverLength /\%81v.\+/               " Highlight chars past column 80

" Formatting settings
set shiftwidth=2                          " Indent shift (<</>>)
set softtabstop=2                         " Indent shift (tab/<bs>)

" NERDTree settings
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | on | endif
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nnoremap <silent> † :NERDTreeToggle<cr>
let NERDTreeShowHidden = 1                " Show hidden files

" NERDCommenter settings
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" Airline settings
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V',
    \ '' : 'V',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ }
let g:airline_theme = 'bubblegum'

" Signature settings
let g:SignatureMarkTextHLDynamic = 1

" Gitgutter settings
set signcolumn=yes

" Incsearch.vim settings
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n <Plug>(incsearch-nohl-n)
map N <Plug>(incsearch-nohl-N)
map * <Plug>(incsearch-nohl-*)
map # <Plug>(incsearch-nohl-#)
map z/ <Plug>(incsearch-fuzzy-/)
map z? <Plug>(incsearch-fuzzy-?)
map zg/ <Plug>(incsearch-fuzzy-g/)

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatusLineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"

let g:syntastic_javascript_checkers = ['eslint']

" Use <C-n> toggle for numbering
let g:UseNumberToggleTrigger = 1

" Set leader key
let mapleader = ","

" Window control
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j<C-w>_z.
nnoremap <C-k> <C-w>k<C-w>_z.
nnoremap <C-l> <C-w>l
nnoremap <Leader><C-j> <C-w>J<C-w>_
nnoremap <Leader><C-k> <C-w>K<C-w>_
nnoremap <C-_> <C-w>_
nnoremap <C-s> <C-w>s<C-w>_z.
nnoremap <C-v> <C-w>v
nnoremap <C-w><C-w> :q<cr><C-w>_

" Move view pane
nnoremap ∆ <C-e>
nnoremap ˚ <C-y>
nnoremap ≥ z.

" Disable arrow keys in insert mode
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Writing and quitting keymaps
nnoremap <Leader>qq :q<cr><C-w>_
nnoremap <Leader>QQ :q!<cr><C-w>_
nnoremap <Leader>qa :qa<cr>
nnoremap <Leader>QA :qa!<cr>
nnoremap <Leader>ww :w<cr>
nnoremap <Leader>wq :wq<cr><C-w>_

" Avoid escape
inoremap jd <esc>

" Niceties
inoremap <Leader>o <C-c>o
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>

" Swap 0^
noremap 0 ^
noremap ^ 0
