autocmd FileType potion :let maplocalleader='\\'

if !exists("g:potion_command")
  let g:potion_command = "~/Documents/potion/bin/potion"
endif

function! s:PotionCompileAndRunFile()
  write
  silent !clear
  execute "!" . g:potion_command . " " . bufname("%")
endfunction


function! s:PotionShowBytecode()
  write
  " Get the bytecode.
  let bytecode = system(g:potion_command . " -c -V " . bufname("%") . " 2>&1")
  " Open a new split and set it up.

  let bufnumber = bufwinnr("__Potion_Bytecode__")
  if bufnumber !=# -1
    silent bwipeout __Potion_Bytecode__
  endif

  vsplit __Potion_Bytecode__
  normal! ggdG
  setlocal filetype=potionbytecode
  setlocal buftype=nofile

  " Insert the bytecode.
  call append(0, split(bytecode, '\v\n'))
endfunction

nnoremap <buffer> <localleader>r :call <SID>PotionCompileAndRunFile()<cr>
nnoremap <buffer> <localleader>b :call <SID>PotionShowBytecode()<cr>















