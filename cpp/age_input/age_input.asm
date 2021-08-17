176: int main (int argc, char **argv, char **envp);
; var int64_t var_ch @ rbp-0xc
; var int64_t canary @ rbp-0x8
endbr64 
push rbp 		      ==> Push base pointer on to stack
mov rbp, rsp		      ==> Copy stack pointer to base pointer
sub rsp, 0x10		      ==> Take 16 bytes from the stack pointer 
mov rax, qword fs:[0x28]      ==> Stack Guard value initialization 
mov qword [canary], rax       ==> copy rax value into canary
xor eax, eax		      ==> Zero out eax
mov dword [var_ch], 0	      ==> Copy zero value to var_ch
lea rsi, str.How_old_are_you  ==> Load mem address of "How old" string to rsi(scond arg)
lea rdi, std::cout 	      ==> Load mem address of cout function to rdi(first arg)
call std::basic_ostream<char> ==> Call std output stream function
mov rdx, rax		      ==> Copy canary value to rdx (?)
mov rax, qword [method.std::] ==> Copy standard ostream to rax (returning output)
mov rsi, rax		      ==> Copy output stream to second arg rsi
mov rdi, rdx		      ==> Copy ouput to rdi(?)
call std::ostream	      ==> Call std ostream function
lea rax, [var_ch]	      ==> load address of var_ch to the rax register
mov rsi, rax		      ==> Copy the var_ch address to rsi(second arg)
lea rdi, std::cin	      ==> Call std::cin function,take input to rdi (first arg)
call section..plt.sec	      ==> Procedure Linking Table, call func with unkwn addr
lea rsi, str.You_have_entered ==> Load address of "you entered" string to rsi (2nd arg)lea rdi, std::cout	     ==> Copy std::cout function to rdi (1st arg)
call std::basic_ostream	      ==> Call std::ostream function
mov rdx, rax		      ==> Copy return value to rdx (?)
mov eax, dword [var_ch]	      ==> Copy var_ch value to eax
mov esi, eax
mov rdi, rdx
call std::ostream	      ==> Call std ouputstream function
mov rdx, rax
mov rax, qword [endl_char_std]==> Copy endl to rax
mov rsi, rax
mov rdi, rdx
call std::ostream::operator   ==> Call std::ostream function to print endl / newline
mov eax, 0		      ==> Zero out eax register
mov rcx, qword [canary]	      ==> Copy canary value to rcx
xor rcx, qword fs:[0x28]      ==> complete bitwise op compare canary to init at start
je 0x564d764782b7	      ==> If jump is equal, jmp to leave
call __stack_chk_fail	      ==> stack check will be hit if above jump is not equal
leave			      ==> leave function
ret			      ==> return everything as it was
