;function4.asm external functions

extern printf
extern c_area
extern c_circum
extern r_area
extern r_circum
global pi

section .data
	pi 	dq 3.141592654
	radius	dq 10.0
	side1	dq 4
	side2	dq 5
	fmtf	db "%s %f",10,0
	fmti	db "%s %d",10,0
	ca	db "The Circle area is ",0
	cc	db "The Circle circumference is ",0
	ra	db "The Rectangle area is ",0
	rc	db "The Rectangle circumference is ",0
section .bss
section .text
	global main
main:
	push rbp
	mov rbp,rsp
	;circle area
	movsd xmm0, qword [radius] ;radious xmm0 arg
	call c_area ;area returned in xmm0
	;print the circle area
	mov rdi, fmtf ;move string for stdout
	mov rsi, ca ;our string to write out
	mov rax, 1 ;1=sys_write
	call printf ;call printf
	
	;circle circumference
	movsd xmm0, qword [radius]
	call c_circum
	;print circle circumference
	mov rdi, fmti
	mov rsi, cc
	mov rax, 1
	call printf

	;rectangle area
	mov rdi, [side1]
	mov rsi, [side2]
	call r_area ;area is returned in rax
	
	;print rectangle area
	mov rdi, fmti
	mov rsi, ra
	mov rdx, rax
	mov rax, 0
	call printf

	;rectangle circumference
	mov rdi, [side1]
	mov rsi, [side2]
	call r_circum ;circum returned in rax
	mov rdi, fmti
	mov rsi, rc
	mov rdx, rax
	mov rax, 0
	call printf

	mov rsp,rbp
	pop rbp
	ret


