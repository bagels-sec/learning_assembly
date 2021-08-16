push    rbp 		       ==> Push the base pointer on to the stack
mov     rbp, rsp	       ==> Copy the stack pointer to the base pointer value
lea     rsi, str.Hello_World   ==> Load effective address of "Hello World" into RSI
lea     rdi, std::cout 	       ==> Load effective address of std::cout func into RDI
call    std::basic_ostream     ==> Call std output stream function 
mov     rdx, rax 	       ==> Copy return value to RDX
mov     rax, qword [std::endl] ==> Copy std::endl function to rax 
mov     rsi, rax 	       ==> Return Hello World string
mov     rdi, rdx	       ==> Copy 3rd arg (rdx) to rdi value
call    std::ostream::operator ==> Call std::ostream function
mov     eax, 0		       ==> return 0
pop     rbp		       ==> pop the base pointer from the stack
ret 			       ==> return flow
