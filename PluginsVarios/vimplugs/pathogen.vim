
<!-- saved from url=(0070)https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim -->
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></head><body><pre style="word-wrap: break-word; white-space: pre-wrap;">" pathogen.vim - path option manipulation
" Maintainer:   Tim Pope &lt;http://tpo.pe/&gt;
" Version:      2.2

" Install in ~/.vim/autoload (or ~\vimfiles\autoload).
"
" For management of individually installed plugins in ~/.vim/bundle (or
" ~\vimfiles\bundle), adding `call pathogen#infect()` to the top of your
" .vimrc is the only other setup necessary.
"
" The API is documented inline below.  For maximum ease of reading,
" :set foldmethod=marker

if exists("g:loaded_pathogen") || &amp;cp
  finish
endif
let g:loaded_pathogen = 1

function! s:warn(msg)
  if &amp;verbose
    echohl WarningMsg
    echomsg a:msg
    echohl NONE
  endif
endfunction

" Point of entry for basic default usage.  Give a relative path to invoke
" pathogen#incubate() (defaults to "bundle/{}"), or an absolute path to invoke
" pathogen#surround().  For backwards compatibility purposes, a full path that
" does not end in {} or * is given to pathogen#runtime_prepend_subdirectories()
" instead.
function! pathogen#infect(...) abort " {{{1
  for path in a:0 ? reverse(copy(a:000)) : ['bundle/{}']
    if path =~# '^[^\\/]\+$'
      call s:warn('Change pathogen#infect('.string(path).') to pathogen#infect('.string(path.'/{}').')')
      call pathogen#incubate(path . '/{}')
    elseif path =~# '^[^\\/]\+[\\/]\%({}\|\*\)$'
      call pathogen#incubate(path)
    elseif path =~# '[\\/]\%({}\|\*\)$'
      call pathogen#surround(path)
    else
      call s:warn('Change pathogen#infect('.string(path).') to pathogen#infect('.string(path.'/{}').')')
      call pathogen#surround(path . '/{}')
    endif
  endfor
  call pathogen#cycle_filetype()
  return ''
endfunction " }}}1

" Split a path into a list.
function! pathogen#split(path) abort " {{{1
  if type(a:path) == type([]) | return a:path | endif
  let split = split(a:path,'\\\@&lt;!\%(\\\\\)*\zs,')
  return map(split,'substitute(v:val,''\\\([\\,]\)'',''\1'',"g")')
endfunction " }}}1

" Convert a list to a path.
function! pathogen#join(...) abort " {{{1
  if type(a:1) == type(1) &amp;&amp; a:1
    let i = 1
    let space = ' '
  else
    let i = 0
    let space = ''
  endif
  let path = ""
  while i &lt; a:0
    if type(a:000[i]) == type([])
      let list = a:000[i]
      let j = 0
      while j &lt; len(list)
        let escaped = substitute(list[j],'[,'.space.']\|\\[\,'.space.']\@=','\\&amp;','g')
        let path .= ',' . escaped
        let j += 1
      endwhile
    else
      let path .= "," . a:000[i]
    endif
    let i += 1
  endwhile
  return substitute(path,'^,','','')
endfunction " }}}1

" Convert a list to a path with escaped spaces for 'path', 'tag', etc.
function! pathogen#legacyjoin(...) abort " {{{1
  return call('pathogen#join',[1] + a:000)
endfunction " }}}1

" Remove duplicates from a list.
function! pathogen#uniq(list) abort " {{{1
  let i = 0
  let seen = {}
  while i &lt; len(a:list)
    if (a:list[i] ==# '' &amp;&amp; exists('empty')) || has_key(seen,a:list[i])
      call remove(a:list,i)
    elseif a:list[i] ==# ''
      let i += 1
      let empty = 1
    else
      let seen[a:list[i]] = 1
      let i += 1
    endif
  endwhile
  return a:list
endfunction " }}}1

" \ on Windows unless shellslash is set, / everywhere else.
function! pathogen#separator() abort " {{{1
  return !exists("+shellslash") || &amp;shellslash ? '/' : '\'
endfunction " }}}1

" Convenience wrapper around glob() which returns a list.
function! pathogen#glob(pattern) abort " {{{1
  let files = split(glob(a:pattern),"\n")
  return map(files,'substitute(v:val,"[".pathogen#separator()."/]$","","")')
endfunction "}}}1

" Like pathogen#glob(), only limit the results to directories.
function! pathogen#glob_directories(pattern) abort " {{{1
  return filter(pathogen#glob(a:pattern),'isdirectory(v:val)')
endfunction "}}}1

" Turn filetype detection off and back on again if it was already enabled.
function! pathogen#cycle_filetype() " {{{1
  if exists('g:did_load_filetypes')
    filetype off
    filetype on
  endif
endfunction " }}}1

" Check if a bundle is disabled.  A bundle is considered disabled if it ends
" in a tilde or its basename or full name is included in the list
" g:pathogen_disabled.
function! pathogen#is_disabled(path) " {{{1
  if a:path =~# '\~$'
    return 1
  elseif !exists("g:pathogen_disabled")
    return 0
  endif
  let sep = pathogen#separator()
  let blacklist = g:pathogen_disabled
  return index(blacklist, strpart(a:path, strridx(a:path, sep)+1)) != -1 &amp;&amp; index(blacklist, a:path) != 1
endfunction "}}}1

" Prepend the given directory to the runtime path and append its corresponding
" after directory.  If the directory is already included, move it to the
" outermost position.  Wildcards are added as is.  Ending a path in /{} causes
" all subdirectories to be added (except those in g:pathogen_disabled).
function! pathogen#surround(path) abort " {{{1
  let sep = pathogen#separator()
  let rtp = pathogen#split(&amp;rtp)
  if a:path =~# '[\\/]{}$'
    let path = fnamemodify(a:path[0:-4], ':p:s?[\\/]\=$??')
    let before = filter(pathogen#glob_directories(path.sep.'*'), '!pathogen#is_disabled(v:val)')
    let after  = filter(reverse(pathogen#glob_directories(path.sep."*".sep."after")), '!pathogen#is_disabled(v:val[0:-7])')
    call filter(rtp,'v:val[0:strlen(path)-1] !=# path')
  else
    let path = fnamemodify(a:path, ':p:s?[\\/]\=$??')
    let before = [path]
    let after = [path . sep . 'after']
    call filter(rtp, 'index(before + after, v:val) == -1')
  endif
  let &amp;rtp = pathogen#join(before, rtp, after)
  return &amp;rtp
endfunction " }}}1

" Prepend all subdirectories of path to the rtp, and append all 'after'
" directories in those subdirectories.  Deprecated.
function! pathogen#runtime_prepend_subdirectories(path) " {{{1
  call s:warn('Change pathogen#runtime_prepend_subdirectories('.string(a:path).') to pathogen#surround('.string(a:path.'/{}').')')
  return pathogen#surround(a:path . pathogen#separator() . '{}')
endfunction " }}}1

" For each directory in the runtime path, add a second entry with the given
" argument appended.  If the argument ends in '/{}', add a separate entry for
" each subdirectory.  The default argument is 'bundle/{}', which means that
" .vim/bundle/*, $VIM/vimfiles/bundle/*, $VIMRUNTIME/bundle/*,
" $VIM/vim/files/bundle/*/after, and .vim/bundle/*/after will be added (on
" UNIX).
function! pathogen#incubate(...) abort " {{{1
  let sep = pathogen#separator()
  let name = a:0 ? a:1 : 'bundle/{}'
  if "\n".s:done_bundles =~# "\\M\n".name."\n"
    return ""
  endif
  let s:done_bundles .= name . "\n"
  let list = []
  for dir in pathogen#split(&amp;rtp)
    if dir =~# '\&lt;after$'
      if name =~# '{}$'
        let list +=  filter(pathogen#glob_directories(substitute(dir,'after$',name[0:-3],'').'*[^~]'.sep.'after'), '!pathogen#is_disabled(v:val[0:-7])') + [dir]
      else
        let list += [dir, substitute(dir, 'after$', '', '') . name . sep . 'after']
      endif
    else
      if name =~# '{}$'
        let list +=  [dir] + filter(pathogen#glob_directories(dir.sep.name[0:-3].'*[^~]'), '!pathogen#is_disabled(v:val)')
      else
        let list += [dir . sep . name, dir]
      endif
    endif
  endfor
  let &amp;rtp = pathogen#join(pathogen#uniq(list))
  return 1
endfunction " }}}1

" Deprecated alias for pathogen#incubate().
function! pathogen#runtime_append_all_bundles(...) abort " {{{1
  if a:0
    call s:warn('Change pathogen#runtime_append_all_bundles('.string(a:1).') to pathogen#incubate('.string(a:1.'/{}').')')
  else
    call s:warn('Change pathogen#runtime_append_all_bundles() to pathogen#incubate()')
  endif
  return call('pathogen#incubate', map(copy(a:000),'v:val . "/{}"'))
endfunction

let s:done_bundles = ''
" }}}1

" Invoke :helptags on all non-$VIM doc directories in runtimepath.
function! pathogen#helptags() abort " {{{1
  let sep = pathogen#separator()
  for glob in pathogen#split(&amp;rtp)
    for dir in split(glob(glob), "\n")
      if (dir.sep)[0 : strlen($VIMRUNTIME)] !=# $VIMRUNTIME.sep &amp;&amp; filewritable(dir.sep.'doc') == 2 &amp;&amp; !empty(filter(split(glob(dir.sep.'doc'.sep.'*'),"\n&gt;"),'!isdirectory(v:val)')) &amp;&amp; (!filereadable(dir.sep.'doc'.sep.'tags') || filewritable(dir.sep.'doc'.sep.'tags'))
        helptags `=dir.'/doc'`
      endif
    endfor
  endfor
endfunction " }}}1

command! -bar Helptags :call pathogen#helptags()

" Execute the given command.  This is basically a backdoor for --remote-expr.
function! pathogen#execute(...) abort " {{{1
  for command in a:000
    execute command
  endfor
  return ''
endfunction " }}}1

" Like findfile(), but hardcoded to use the runtimepath.
function! pathogen#runtime_findfile(file,count) abort "{{{1
  let rtp = pathogen#join(1,pathogen#split(&amp;rtp))
  let file = findfile(a:file,rtp,a:count)
  if file ==# ''
    return ''
  else
    return fnamemodify(file,':p')
  endif
endfunction " }}}1

" Backport of fnameescape().
function! pathogen#fnameescape(string) abort " {{{1
  if exists('*fnameescape')
    return fnameescape(a:string)
  elseif a:string ==# '-'
    return '\-'
  else
    return substitute(escape(a:string," \t\n*?[{`$\\%#'\"|!&lt;"),'^[+&gt;]','\\&amp;','')
  endif
endfunction " }}}1

if exists(':Vedit')
  finish
endif

let s:vopen_warning = 0

function! s:find(count,cmd,file,lcd) " {{{1
  let rtp = pathogen#join(1,pathogen#split(&amp;runtimepath))
  let file = pathogen#runtime_findfile(a:file,a:count)
  if file ==# ''
    return "echoerr 'E345: Can''t find file \"".a:file."\" in runtimepath'"
  endif
  if !s:vopen_warning
    let s:vopen_warning = 1
    let warning = '|echohl WarningMsg|echo "Install scriptease.vim to continue using :V'.a:cmd.'"|echohl NONE'
  else
    let warning = ''
  endif
  if a:lcd
    let path = file[0:-strlen(a:file)-2]
    execute 'lcd `=path`'
    return a:cmd.' '.pathogen#fnameescape(a:file) . warning
  else
    return a:cmd.' '.pathogen#fnameescape(file) . warning
  endif
endfunction " }}}1

function! s:Findcomplete(A,L,P) " {{{1
  let sep = pathogen#separator()
  let cheats = {
        \'a': 'autoload',
        \'d': 'doc',
        \'f': 'ftplugin',
        \'i': 'indent',
        \'p': 'plugin',
        \'s': 'syntax'}
  if a:A =~# '^\w[\\/]' &amp;&amp; has_key(cheats,a:A[0])
    let request = cheats[a:A[0]].a:A[1:-1]
  else
    let request = a:A
  endif
  let pattern = substitute(request,'/\|\'.sep,'*'.sep,'g').'*'
  let found = {}
  for path in pathogen#split(&amp;runtimepath)
    let path = expand(path, ':p')
    let matches = split(glob(path.sep.pattern),"\n")
    call map(matches,'isdirectory(v:val) ? v:val.sep : v:val')
    call map(matches,'expand(v:val, ":p")[strlen(path)+1:-1]')
    for match in matches
      let found[match] = 1
    endfor
  endfor
  return sort(keys(found))
endfunction " }}}1

command! -bar -bang -range=1 -nargs=1 -complete=customlist,s:Findcomplete Ve       :execute s:find(&lt;count&gt;,'edit&lt;bang&gt;',&lt;q-args&gt;,0)
command! -bar -bang -range=1 -nargs=1 -complete=customlist,s:Findcomplete Vedit    :execute s:find(&lt;count&gt;,'edit&lt;bang&gt;',&lt;q-args&gt;,0)
command! -bar -bang -range=1 -nargs=1 -complete=customlist,s:Findcomplete Vopen    :execute s:find(&lt;count&gt;,'edit&lt;bang&gt;',&lt;q-args&gt;,1)
command! -bar -bang -range=1 -nargs=1 -complete=customlist,s:Findcomplete Vsplit   :execute s:find(&lt;count&gt;,'split',&lt;q-args&gt;,&lt;bang&gt;1)
command! -bar -bang -range=1 -nargs=1 -complete=customlist,s:Findcomplete Vvsplit  :execute s:find(&lt;count&gt;,'vsplit',&lt;q-args&gt;,&lt;bang&gt;1)
command! -bar -bang -range=1 -nargs=1 -complete=customlist,s:Findcomplete Vtabedit :execute s:find(&lt;count&gt;,'tabedit',&lt;q-args&gt;,&lt;bang&gt;1)
command! -bar -bang -range=1 -nargs=1 -complete=customlist,s:Findcomplete Vpedit   :execute s:find(&lt;count&gt;,'pedit',&lt;q-args&gt;,&lt;bang&gt;1)
command! -bar -bang -range=1 -nargs=1 -complete=customlist,s:Findcomplete Vread    :execute s:find(&lt;count&gt;,'read',&lt;q-args&gt;,&lt;bang&gt;1)

" vim:set et sw=2:
</pre></body></html>