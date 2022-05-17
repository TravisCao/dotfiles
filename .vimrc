syntax on
set number
set cindent
set autoindent
set showmatch
set ruler

" ls -l /usr/share/vim/vim80/colors
colorscheme torte
set paste
set ruler

filetype plugin indent on
filetype indent on

" basic settings for yaml and python files
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab number autoindent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab autoindent
autocmd FileType cpp setlocal ts=4 sts=4 sw=4 expandtab number autoindent smartindent

" folding can help troubleshoot indentation syntax
set foldenable
set foldlevelstart=20
set foldmethod=indent
set backspace=indent,eol,start  " more powerful backspacing
