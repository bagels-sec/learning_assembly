;alive.asm
extern printf
section .data
	msg1    db  "Hello, World",10,0 ; Defining our string with newline at the end
	msg1Len equ $-msg1-1 		; Measure the length of msg1 minus the 0
	msg2	db  "Alive and Kicking",10,0 ;Define second message with newline at the end
	msg2Len equ $-msg2-1		; Get lenght of msg2 minus 0 at the end
	radius  dq  357
	pi	dq  3.14
	fmtflt	db  "%lf",10,0
	fmtstr  db "%s",10,0
	fmtint  db "%d",10,0
section .bss
section .text
	global main
	main:
		push rbp
		mov rbp,rsp
		mov rax,0
		mov rdi, fmtstr
		mov rsi, msg1
		call printf
		mov rax,0
		mov rdi, fmtstr
		mov rsi, msg2
		call printf
		mov rax,0
		mov rdi, fmtint
		mov rsi, [radius]
		call printf
		mov rax, 1
		movq xmm0, [pi]
		mov rdi, fmtflt
		call printf
		mov rsp, rbp
		pop rbp
		ret
