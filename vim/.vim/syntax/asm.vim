"Vim syntax file
"Language: Assembly
"Maintainer: Harper Weigle
"Last Change: 2/4/2020
"
"place in .vim/syntax

if exists("b:current_syntax")
  finish
endif

syn match ASMdirective "\.[A-Za-z][0-9A-Za-z-_]*"

" storage types
syn match asmType "\.long"
syn match asmType "\.ascii"
syn match asmType "\.asciz"
syn match asmType "\.byte"
syn match asmType "\.double"
syn match asmType "\.float"
syn match asmType "\.hword"
syn match asmType "\.int"
syn match asmType "\.octa"
syn match asmType "\.quad"
syn match asmType "\.short"
syn match asmType "\.single"
syn match asmType "\.space"
syn match asmType "\.string"
syn match asmType "\.word"

"instr
syn match ASMinstr "\spush"
syn match ASMinstr "\smov\w*"
syn match ASMinstr "\smul\w*"
syn match ASMinstr "\ssub\w*"
syn match ASMinstr "\sadd\w*"
syn match ASMinstr "\sstr\w*"
syn match ASMinstr "\sldr\w*"
syn match ASMinstr "\sLDR\w*"
syn match ASMinstr "\sb\w*"
syn match ASMinstr "\ssmul\w*"
syn match ASMinstr "\sand\w*"
syn match ASMinstr "\scmp\w*"
syn match ASMinstr "\slsls\w*"
syn match ASMinstr "\srsrs\w*"
syn match ASMinstr "\spop\w*"
syn match ASMinstr "\sit\w*"
syn match ASMinstr "\sLSL\w*"
syn match ASMinstr "\slsl\w*"
syn match ASMinstr "\sRSR\w*"
syn match ASMinstr "\sNOP\w*"
syn match ASMinstr "\snop\w*"
syn match ASMinstr "\smla\w*"
syn match ASMinstr "\smls\w*"
syn match ASMcond "IT[TE]*"

syn match ASMfunc "[a-z_][a-z0-9_]*"
syn match ASMlabel "[a-z_][a-z0-9_]*:"he=e-1

"comments
syn match ASMcomment "@.*$" contains=alert
syn keyword ASMtodo contained TODO
syn region ASMcomment start="/\*" end="\*/" contains=ASMtodo

"Special Values
syn match ASMregister "r[0-9][012]*"
syn keyword ASMregister lr sp pc

"Numbers
syn match ASMnumber		"0\+[1-7]\=[\t\n$,; ]"
syn match ASMnumber		"[1-9]\d*"
syn match ASMnumber		"0[0-7][0-7]\+"
syn match ASMnumber		"#[0-9a-fA-F]\+"
syn match ASMnumber		"0[bB][0-1]*"

syn match ASMinclude "\.include"

let b:current_syntax = "asm"

hi def link ASMcomment Comment
hi def link ASMlabel Label
hi def link ASMfunc Identifier
hi def link ASMregister Special
hi def link ASMnumber Number
hi def link ASMinstr PreProc
hi def link ASMtype Type
hi def link ASMtodo Todo
hi def link ASMdirective Statement
hi def link ASMinclude Include
hi def link ASMcond PreCondit
