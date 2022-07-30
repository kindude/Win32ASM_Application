.386	
.model flat, stdcall

include d:\masm32\include\masm32rt.inc

.stack	100h
; option casemap :none
.DATA
	a dw 28
	b dw 2
	cc dw 18
	const dw 22, 18, 74
	res1 dd ?
	res2 dd ?

;(A +22) * B-18/C+74
;	1   2  4  3 5

;22 A + B* 18 C/ - 74 +

.CODE
main PROC
;Сопроцессор 
finit
fild const
fild a
faddp st(1), st(0)
fild b
fmulp st(1), st(0)
fist res1
fild cc
fild const + 2
fdivp st(1), st(0)
fild word ptr[res1]
fxch st(1)
fsubp st(1), st(0)
fild const + 4
faddp st(1),st(0)
fist res1
    invoke ExitProcess, 0
main ENDP
END main

.386	
.model flat, stdcall
include d:\masm32\include\masm32rt.inc
.stack	100h
; option casemap :none
.DATA
	a dw 28
	b dw 2
	cc dw 18
	const dw 22, 18, 74
	res1 dd ?
	res2 dd ?
;(A +22) * B-18/C+74
;	1   2  4  3 5

;22 A + B* 18 C/ - 74 +
.CODE
main PROC
;Процессор 
mov ax, a
mov bx, const
add ax, bx
mov bx, b
mul b
mov word ptr[res2], ax
mov ax,cc
div const + 2
mov bx, ax
mov ax, word ptr[res2]
sub ax, bx
adc ax, const + 4
mov word ptr[res2], ax
    invoke ExitProcess, 0
main ENDP

END main
