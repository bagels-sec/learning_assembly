section .data
section .bss
section .text
global asum
asum:
	section .text
		mov rcx, rsi ;array length
		mov rbx, rsi ;address of array
		mov r12, 0
		movsd xmm0, qword[rbx+r12*8]
		dec rcx
		sloop:
			inc r12
			addsd xmm0, qword[rbx+r12*8]
			loop sloop
			ret

