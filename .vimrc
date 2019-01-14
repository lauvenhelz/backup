set nocompatible
set hidden

call plug#begin('~/.vim/plugged')
Plug 'baverman/vial'
Plug 'baverman/vial-pipe'
Plug 'baverman/vial-http'
Plug 'vim-scripts/tComment'
call plug#end()

let mapleader = ','

function! InitVialHttpBuf()
    nnoremap <buffer> <leader><cr> :VialHttp<cr>
endfunction

function! InitMongoBuf()
    setfiletype javascript
    nmap <buffer> <leader><cr> <Plug>VialPipeExecute
    vmap <buffer> <leader><cr> <Plug>VialPipeExecute
endfunction

function! InitPythonBuf()
    nmap <buffer> <leader><cr> <Plug>VialPipeExecuteAll
endfunction

function! InitSqlBuf()
    nmap <buffer> <leader><cr> <Plug>VialPipeExecute
    vmap <buffer> <leader><cr> <Plug>VialPipeExecute
endfunction

augroup MyFileTypeSettings
    au!
    au FileType qf wincmd J
    au FileType vial-http call InitVialHttpBuf()
    au FileType python call InitPythonBuf()
    au BufNewFile __vial_http__ nnoremap <buffer> <silent> <c-k> :b __vial_http_req__<cr>
    au BufNewFile __vial_http_req__ nnoremap <buffer> <silent> <c-k> :b __vial_http_hdr__<cr>
    au BufNewFile __vial_http_hdr__ nnoremap <buffer> <silent> <c-k> :b __vial_http__<cr>
    au BufNewFile,BufRead *.mongo call InitMongoBuf()
    au BufNewFile,BufRead *.sql call InitSqlBuf()
augroup END
