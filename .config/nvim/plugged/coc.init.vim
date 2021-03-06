" Install coc plugins.
function! CocPluginInstall()
    CocInstall
                \ coc-cmake
                \ coc-css
                \ coc-diagnostic
                \ coc-explorer
                \ coc-highlight
                \ coc-html
                \ coc-json
                \ coc-lua
                \ coc-markdownlint
                \ coc-python
                \ coc-r-lsp
                \ coc-rust-analyzer
                \ coc-sh
                \ coc-texlab            " The `texlab` executable should be
                                        " installed manually
                \ coc-yaml
endfunction
function! CocToggle()
    let l:coc_enabled = get(b:, 'coc_enabled', 1)
    if l:coc_enabled
        let b:coc_enabled = 0
        exec 'CocDisable'
    else
        let b:coc_enabled = 1
        exec 'CocRestart'
    endif
endfunction
autocmd BufEnter * silent noremap <leader>cpi :call CocPluginInstall()<CR>
autocmd BufEnter * silent noremap <leader>cx  :call CocToggle()<CR>
" Example configuration for coc.
" From: https://github.com/neoclide/coc.nvim#example-vim-configuration

" Set texlab TeX auto-completion
let g:tex_flavor = 'latex'

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=1

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[e` and `]e` to navigate through diagnostics
nmap <silent> [e <Plug>(coc-diagnostic-prev)
nmap <silent> ]e <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)zz
nmap <silent> gy <Plug>(coc-type-definition)zz
nmap <silent> gm <Plug>(coc-implementation)zz
nmap <silent> gr <Plug>(coc-references)zz

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

let s:coc_highlight_enabled = 0
let g:coc_highlight_disable_size_threshold = 524288
function ActivateCocCursorHoldAction()
    if getfsize(expand('<afile>')) < g:coc_highlight_disable_size_threshold
        if s:coc_highlight_enabled == 0
            autocmd CursorHold * silent call CocActionAsync('highlight')
            " hi CocHighlightText guibg=#123e70
            let s:coc_highlight_enabled = 1
        endif
    else
        autocmd! CursorHold *
        let s:coc_highlight_enabled = 0
        echom 'File too large, not enabling highlighting on CursorHold'
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
" Supports file size up to 512 KB (524288 B)
autocmd BufEnter * silent call ActivateCocCursorHoldAction()

" Symbol renaming.
autocmd BufEnter * nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup cocinitaugroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
autocmd BufEnter * nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" NOTE: Coc statusline is disabled.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" " Mappings using CoCList:
" Use CocFzfList instead of CocList for better fuzzy finding experience
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocFzfList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocFzfList -I extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocFzfList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocFzfList outline<cr>
" " Search workspace symbols.
" nnoremap <silent> <space>s  :<C-u>CocFzfList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocFzfListResume<CR>
