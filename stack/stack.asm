;stack.asm

extern printf ;Load the external printf function

section .data
  strng db  "ABCDE",0 			;define string with 0/NL
  strngLen equ $-strng-1 		;Length of strng is strng-1(0 at the end)
  fmt1	db  "The original String: %s",10,0
  fmt2  db  "The reverse String: %s",10,0
section .bss
section .text
  global main:
main:
push rbp
mov rbp,rsp

;Print the original string
mov rdi,fmt1
mov rsi,strng
mov rax,0
call printf

;Push the string char by char on to the stack
mov rax,0
mov rbx,strng ;copy address of strng into rbx
mov rcx,strngLen ;copy strnglen into rcx counter 
mov r12,0 ;use r12 pointer
pushLoop:
  mov al,byte [rbx+r12] ;move single char into rax
  push rax ;pus rax on to the stack
  inc r12 ;increase char pointer with 1
  loop pushLoop ;continue the loop
 
;pop the string char per char from the stack
;this will reverse the original string

mov rbx,strng ;address of strng in rbx
mov rcx,strngLen ;length in rcx counter
mov r12,0 ;use r12 as pointer
popLoop:
  pop rax ;pop char from the stack
  mov byte [rbx+r12],al ;move the char into strng
  inc r12 ;increease char pointer with 1
  loop popLoop
mov byte [rbx+r12],0 ;terminate string with 0
;print the reversed string
mov rdi,fmt2
mov rsi,strng
mov rax,0
call printf

mov rsp,rbp
pop rbp
ret

