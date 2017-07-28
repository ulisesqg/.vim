"""""""""""""""""""""""
" GENERAL CONFIG      "
"""""""""""""""""""""""

set nocompatible                        " disable vi compatibility
set history=1000                        " set how many lines vim has to remember
set autoread                            " autoread when file is modified from outside

" stop vim from creating backup files
set noswapfile
set nobackup
set nowb


" disable arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" remap ESC
noremap uu <ESC>
imap uu <ESC>

" smart way to move between windows
map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l

" maps for easily move lines
map <S-Up> :m-2<CR>
map <S-Down> :m+1<CR>

" maps for move in lines
map <S-Left> 0
map <S-Right> $
imap <S-Left> <ESC>I
imap <S-Right> <ESC>A

" copy and paste and available in os clipboad
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa
""""""""""""""""""""""
" PLUGINS            "
""""""""""""""""""""""

" Vundle config
filetype off                            " required by Vundle
set rtp+=~/.vim/bundle/Vundle.vim       " set runtime path
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'           " let's Vundle manage Vundle
Plugin 'scrooloose/NERDTree'            " NERDTree file explorer
Plugin 'kien/ctrlp.vim'                 " file finder
Plugin 'ntpeters/vim-better-whitespace' " better whitespaces
Plugin 'nathanaelkane/vim-indent-guides'        " visually display indentation
Plugin 'vim-syntastic/syntastic'        " syntax checker
Plugin 'jiangmiao/auto-pairs'           " auto pair quotes, brackets etc
Plugin 'vim-airline/vim-airline'        " better status bar
Plugin 'vim-airline/vim-airline-themes' " themes for airline
Plugin 'tpope/vim-fugitive'             " vim wrapper for git
Plugin 'valloric/youcompleteme'         " autocomplete for vim
Plugin 'mattn/emmet-vim'                " emmet

" colorschemes
Plugin 'danilo-augusto/vim-afterglow'
Plugin 'morhetz/gruvbox'
Plugin 'endel/vim-github-colorscheme'

call vundle#end()
filetype plugin indent on               " reenable file detection, plugin and indent disabled by Vundle

"""""""""""""""""""""""
" PLUGINS CONFIG      "
"""""""""""""""""""""""

" NERDTree
" autostart NERDTree only if no file is requested
function! StartUp()
        if !exists("s:std_in") && 0 == argc()
                NERDTree
        end
endfunction

autocmd VimEnter * call StartUp()
autocmd StdinReadPre * pre s:std_in=1   
let g:NERDTreeShowHidden=1              " show hidden files in NERDTree
let g:NERDTreeWinSize=20                " NERDTree window size
" close NERDTree if there is no opened buffers
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" activate/deactivate NERDTree
nmap <Leader>nt :NERDTreeToggle<cr>

" CtrlP settings
let g:ctrlp_match_window="bottom,order:ttb"
let g:ctrlp_switch_buffer=0
let g:ctrlp_working_path_mode=0
let g:ctrlp_user_command='ag %s -l --nocolor --hidden -g ""'


" IndentGuides
let g:indent_guides_enable_on_vim_startup = 1 "start vim with tab highlighting
" toggle indent guides highlight
nmap <F8> :IndentGuidesToggle<CR>
imap <F8> <ESC>:IndentGuidesToggle()<CR>

" Syntastic config
function! GitBranch()
    return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
    let l:branchname = GitBranch()
    return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_javascript_checkers = ['standard']
let g:syntastic_loc_list_height=1
nmap <F9> :Errors<cr>
imap <F9> <ESC>:Errors<cr>

" Airline config
let g:airline_theme='base16'

" Emmet
let g:user_emmet_expandabbr_key=',,'
imap <expr> ,, emmet#expandAbbrIntelligent(",,") 


"""""""""""""""""""""""
" UI CONFIG           "
"""""""""""""""""""""""
set showmatch                           " show matching brackets when text indicator is over them
set softtabstop=4                       " backspace delete tabs
set expandtab                           " tabs are spaces

" colors
syntax enable                           " enable syntax highlighting
set t_Co=256                            " enable 256 colors
colorscheme gruvbox                     " set color scheme
set background=dark
set number                              " show line numbers
set cursorline                          " highlight current line
set cursorcolumn                        " highlight curren column
set relativenumber                      " show line number as relative
set nowrap                              " don't wrap long lines
set showmode                            " always show which mode are we in
set laststatus=2                        " always show statusbar
set wildmenu                            " enable visual wild menu
set ruler                               " always show column and wor position
set lazyredraw                          " redraw only when we need to

" search
set incsearch                           " search as characters are entered
set hlsearch                            " highlight search matches

" folding
set foldenable                          " enable folding
set foldlevelstart=10                   " open most folds by default
set foldnestmax=10                      " 10 nested folds max
set foldmethod=indent                   " fold based on indent level
" space open/closes folds
noremap <space> za
set foldcolumn=1                        " add a bit extra margin to the left

" filetypes
set ffs=unix,mac,dos                    " use unix as standar filetype

" no annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" toggle relative numbers
function! ToggleRelativeNumbers()
        if &relaivenumber == 1
                set norelativenumber
                set number
        else
                set relativenumber
        endif
endfunction
nmap <F5> :call ToggleRelativeNumbers()<CR>
imap <F5> <ESC>:call ToggleRelativeNumbers()<CR>a

if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif
noremap <C-d> :DiffOrig<CR>
