" Otherwise the <C-f> will overwrite the CtrlP mapping
let g:comfortable_motion_no_default_key_mappings = 1

nnoremap <silent> <C-d> :call comfortable_motion#flick(100)<CR>
nnoremap <silent> <C-u> :call comfortable_motion#flick(-100)<CR>

" One mapping to rule them all! Jump to any word, anywhere.
nmap <leader>j <Plug>(easymotion-overwin-w)
