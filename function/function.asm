;function.asm
extern printf
section .data
	radius dq 10.0 ;define radius, dq=quadword
	pi     dq 3.14 ;define pi
	fmt    db "The area of the circle is %2.f",10,0 ;define output string
section .bss
section .txt
	global main
main:
	push rbp     ;<--Prologue --
	mov  rbp,rsp ;--------------
	call area    ;call the area function
	mov rdi,fmt  ;prit our fmt string
	movsd xmm1, [radius] ;move radius float value to xmm1
	mov rax,1    ;area in xmm0
	call printf
	leave
	ret
area:
	push rbp ;<----Prologue --
	mov rbp,rsp ;-------------
	movsd xmm0, [radius] ;move radius float val to xmm0
	mulsd xmm0, [radius]
	mulsd xmm0, [pi] ;multiply xmm0 by float
	leave
	ret

