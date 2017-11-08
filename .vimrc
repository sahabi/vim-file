set nocompatible              " required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'vimwiki/vimwiki'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'vim-pandoc/vim-pandoc'
call vundle#end()            " required
filetype plugin indent on    " required
" vimwiki/vimwiki
let g:vimwiki_list = [
                      \{'path': '~/Dropbox/vimwiki/personal/', 
                      \'syntax': 'markdown', 
                      \'ext': '.md'},
                      \{'path': '~/Dropbox/vimwiki/work/', 
                      \'syntax': 'markdown', 
                      \'ext': '.md'},
                      \{'path': '~/Dropbox/vimwiki/notebook/', 
                      \'syntax': 'markdown', 
                      \'ext': '.md'}
                     \]
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix


highlight BadWhitespace ctermbg=red guibg=darkred

au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/ 
au BufRead,BufNewFile *.tex,*.txt :setlocal spell spelllang=en_us
set encoding=utf-8
map <F2> <esc>:w<cr> ! pdflatex % && xdg-open :echo expand('%:p:h:t') <cr>
Bundle 'Valloric/YouCompleteMe'

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap ev :e ~/.vimrc <CR>
  
"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
	project_base_dir = os.environ['VIRTUAL_ENV']
	activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
	execfile(activate_this, dict(__file__=activate_this))
EOF

let python_highlight_all=1
syntax on

if has('gui_running')
	set background=dark
	colorscheme solarized
else
	colorscheme zenburn
endif

call togglebg#map("<F5>")

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

set nu
set clipboard=unnamed
set tabstop=4
set shiftwidth=4
set expandtab
set backspace=indent,eol,start
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1
set laststatus=2
set t_Co=256
:highlight LineNr ctermfg=blue
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
:highlight Normal ctermfg=white ctermbg=black
let g:airline_theme='silver'
filetype plugin on
set omnifunc=syntaxcomplete#Complete
set directory^=$HOME/.vim/tmp//
let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> -
nnoremap <F5> "=strftime("%H:%M")<CR>P
inoremap <F5> <C-R>=strftime("%H:%M")<CR>
nnoremap <F4> "=strftime("%m/%d/%y")<CR>P
inoremap <F4> <C-R>=strftime("%m/%d/%d")<CR>
let g:pandoc#filetypes#pandoc_markdown = 0
command! Latex execute "silent !pdflatex % && xdg-open %:r.pdf &" | redraw! 
map <F2> :Latex <cr>
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

