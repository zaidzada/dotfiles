" outline.vim - sidebar listing markdown headings, python classes/defs, and
" '" > Section' style headers in other files
"
" :Outline toggles the sidebar. In the sidebar: <CR> jumps, p previews, q closes.

if exists('g:loaded_outline')
    finish
endif
let g:loaded_outline = 1

let s:name = '__Outline__'
let s:src = -1

function! s:ParseMarkdown(lines) abort
    let items = []
    let fence = ''
    for i in range(len(a:lines))
        let m = matchlist(a:lines[i], '^\s*\(```\|\~\~\~\)')
        if !empty(m)
            if empty(fence)
                let fence = m[1]
            elseif m[1] ==# fence
                let fence = ''
            endif
            continue
        endif
        if !empty(fence)
            continue
        endif
        let m = matchlist(a:lines[i], '^\(#\{1,6}\)\s\+\(.\{-}\)\s*#*\s*$')
        if !empty(m)
            call add(items, {'lnum': i + 1, 'level': len(m[1]) - 1, 'text': m[2]})
        endif
    endfor
    return items
endfunction

function! s:ParsePython(lines) abort
    let items = []
    let indents = []    " stack of enclosing def/class indent widths
    for i in range(len(a:lines))
        let line = a:lines[i]
        " '# > Section' headers, same convention as .ctags
        let m = matchlist(line, '^#\+ >\s*\(.*\)')
        if !empty(m)
            let indents = []
            call add(items, {'lnum': i + 1, 'level': 0, 'text': '> ' . m[1]})
            continue
        endif
        let m = matchlist(line, '^\(\s*\)\(class\|def\|async\s\+def\)\s\+\(\w\+\)')
        if empty(m)
            continue
        endif
        let indent = strdisplaywidth(m[1])
        while !empty(indents) && indents[-1] >= indent
            call remove(indents, -1)
        endwhile
        let text = m[2] ==# 'class' ? 'class ' . m[3] : m[3] . '()'
        call add(items, {'lnum': i + 1, 'level': len(indents), 'text': text})
        call add(indents, indent)
    endfor
    return items
endfunction

" '" > Section', '# > Section', '% > Section' headers for any other filetype
function! s:ParseSections(lines) abort
    let items = []
    for i in range(len(a:lines))
        let m = matchlist(a:lines[i], '^\([#"%]\)\1* >\s*\(.*\)')
        if !empty(m)
            call add(items, {'lnum': i + 1, 'level': 0, 'text': '> ' . m[2]})
        endif
    endfor
    return items
endfunction

function! s:Parse(bufnr) abort
    let ft = getbufvar(a:bufnr, '&filetype')
    let lines = getbufline(a:bufnr, 1, '$')
    if ft ==# 'markdown'
        return s:ParseMarkdown(lines)
    elseif ft ==# 'python'
        return s:ParsePython(lines)
    endif
    return s:ParseSections(lines)
endfunction

function! s:WinId() abort
    return bufwinid(s:name)
endfunction

function! s:Render() abort
    let id = s:WinId()
    if id == -1 || !bufexists(s:src)
        return
    endif
    let buf = winbufnr(id)
    let items = s:Parse(s:src)
    let text = map(copy(items), {_, v -> repeat('  ', v.level) . v.text})
    call setbufvar(buf, '&modifiable', 1)
    silent call deletebufline(buf, 1, '$')
    call setbufline(buf, 1, empty(text) ? ['(no symbols)'] : text)
    call setbufvar(buf, '&modifiable', 0)
    call setbufvar(buf, 'outline_items', items)
    call s:Follow()
endfunction

" Move the sidebar cursor to the item enclosing the source cursor.
function! s:Follow() abort
    let id = s:WinId()
    if id == -1 || bufnr('%') != s:src
        return
    endif
    let items = getbufvar(winbufnr(id), 'outline_items', [])
    let cur = line('.')
    let idx = 0
    for i in range(len(items))
        if items[i].lnum > cur
            break
        endif
        let idx = i
    endfor
    call win_execute(id, 'call cursor(' . (idx + 1) . ', 1)')
endfunction

function! s:Jump(stay) abort
    let items = get(b:, 'outline_items', [])
    if empty(items)
        return
    endif
    let item = items[line('.') - 1]
    let outline = win_getid()
    let id = bufwinid(s:src)
    if id == -1
        wincmd p
        execute 'buffer' s:src
    else
        call win_gotoid(id)
    endif
    call cursor(item.lnum, 1)
    normal! zvzt
    if a:stay
        call win_gotoid(outline)
    endif
endfunction

function! s:SetSource() abort
    if &buftype !=# '' || bufname('%') ==# s:name
        return
    endif
    if bufnr('%') != s:src
        let s:src = bufnr('%')
        call s:Render()
    endif
endfunction

function! s:Open() abort
    let s:src = bufnr('%')
    execute 'silent botright vertical' get(g:, 'outline_width', 35) . 'new' s:name
    setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted
    setlocal nonumber norelativenumber nowrap nospell winfixwidth
    setlocal cursorline nomodifiable filetype=outline
    nnoremap <buffer> <silent> <CR> :call <SID>Jump(0)<CR>
    nnoremap <buffer> <silent> p :call <SID>Jump(1)<CR>
    nnoremap <buffer> <silent> q :close<CR>
    syntax match outlineClass /\<class\>/
    syntax match outlineParens /()$/
    syntax match outlineSection /^> .*/
    highlight default link outlineClass Statement
    highlight default link outlineParens Comment
    highlight default link outlineSection Title
    wincmd p
    call s:Render()
endfunction

function! s:Toggle() abort
    let id = s:WinId()
    if id != -1
        call win_execute(id, 'close')
    else
        call s:Open()
    endif
endfunction

command! Outline call s:Toggle()

augroup outline
    autocmd!
    autocmd BufEnter * call s:SetSource()
    autocmd TextChanged,InsertLeave,BufWritePost * if bufnr('%') == s:src | call s:Render() | endif
    autocmd CursorMoved * call s:Follow()
    " Don't leave the sidebar as the last window in a tab
    execute 'autocmd BufEnter' s:name 'if winnr("$") == 1 | quit | endif'
augroup END
