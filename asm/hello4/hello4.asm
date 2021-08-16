; hello.asm
extern printf ; Declare external function
section .data
  msg   db "hello, world", 0
  fmtstr db "This is our sring: %s",10,0 ;print format
section .bss
section .text
  global main
main:
  push rbp
  mov  rbp,rsp
  mov  rdi, fmtstr ;first arguemt for printf
  mov  rsi, msg ; second arg
  mov  rax,0	; no xmm registers needed
  call printf ; call the printf function
  mov rsp,rbp
  pop rbp
  mov rax,60
  mov rdi,0
  syscall
