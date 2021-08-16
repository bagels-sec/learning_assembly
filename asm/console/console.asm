;console.asm

section .data
	msg1 db "Hello, World",10,0
	msg1Len equ $-msg1
	msg2 db "Your Turn",10,0
	msg2Len equ $-msg2
	msg3 db "You Answered",10,0
	msg3Len equ $-msg3

	inputlen equ 10 ;Length of input buffer

section .bss
	input resb inputlen+1 ;provide space for ending 0
section .text
	global main
main:
	push rbp
	mov rbp, rsp

	mov rsi, msg1 ;print the first string
	mov rdx, msg1Len
	call prints

	mov rsi, msg2
	mov rdx, msg2Len
	call prints

	mov rsi, input ;address of input buffer
	mov rdx, inputlen ;length of inputbuffer
	call reads ;wait for input

	mov rsi, msg3 ;print msg3
	mov rdx, msg3Len
	call prints

	mov rdx, inputlen ;length of input buffer
	call prints

	leave
	ret

prints:
	push rbp
	mov rbp,rsp

	; rdi contains address of string
	; rdx contains length of string

	mov rax, 1 ; 1 = write
	mov rdi, 1 ; 1 = stdout
	syscall
	leave
	ret

reads:
	push rbp
	mov rbp,rsp
	
	; rsi contains address of input buffer
	; rdi contains length of input buffer

	mov rax, 0 ; 0 = read
	mov rdi, 1 ; 1 = stdin

	syscall
	leave
	ret
		
