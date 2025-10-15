" custom keyword highlight for @hypr labels in comments, similar to -> TODO
" https://neovim.io/doc/user/syntax.html#%3Asyn-containedin
" cComment matches '/*' style comments, cCommentL matches // comments; these
" keyword vals are set up by the default C syntax highlight at
" $VIMRUNTIME/syntax/c.vim

" custom label for comments in C code during code audits
syntax match Hypr ".hypr:"              containedin=cComment,cCommentL contained
syntax match Bug "BUG"                  containedin=cComment,cCommentL,HyprComment,HyprCommentL contained
syntax match Vuln "VULN\(ERABLE\)\?"    containedin=cComment,cCommentL,HyprComment,HyprCommentL contained

" make regions for the text that comes after the @hypr: label in both comment types
syntax region HyprComment start=".hypr:"hs=e+1 end="\*/"me=e-2  containedin=cComment contains=Hypr,cCommentSkip contained
syntax region HyprCommentL start=".hypr:"hs=e+1 end="$"         containedin=cCommentL contains=Hypr contained

" add some c syntax highlighting for stuff surrounded in backticks inside of comments
syntax region TickedCmt start="`"hs=e+1 end="`"re=e-1           containedin=cComment,cCommentL,@HyprCluster contains=@InnerBackTickC contained

" create a cluster
syntax cluster HyprCluster contains=HyprComment,HyprCommentL
syntax cluster InnerBackTickC contains=cType,cStructure,cOperator,cDefine,cFormat

" set highlights
hi link Vuln cTodo
hi link Bug cTodo

hi Hypr gui=bold guifg=#ef6155
hi HyprComment gui=bold guifg=#ffffff
hi HyprCommentL gui=bold guifg=#ffffff
" hi TickedCmt guifg=Green
