" Vim filetype plugin file
" Language:	CScript
" Maintainer:	Jure Bagić <jurebagic98@gmail.com>
" Last Change:	2025 Feb 22

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
    finish
endif

" Don't load another plugin for this buffer
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR> or using "o".
setlocal fo-=t fo+=croql

" Set 'comments' to format dashed lists in comments.
" Also include ///, used for Doxygen.
setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,:///,://,:#

if (has("gui_win32") || has("gui_gtk")) && !exists("b:browsefilter")
    let b:browsefilter = "CScript Source Files (*.csp)\t*.csp\n"
    if has("win32")
        let b:browsefilter ..= "All Files (*.*)\t*\n"
    else
        let b:browsefilter ..= "All Files (*)\t*\n"
    endif
    let b:undo_ftplugin ..= " | unlet! b:browsefilter"
endif

let &cpo = s:cpo_save
unlet s:cpo_save
