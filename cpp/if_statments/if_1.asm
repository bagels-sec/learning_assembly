var int64_t var_40h		 ==> Variable
var int64_t canary		 ==> stack canary var

push rbp			 ==> Push base pointer
mov rbp, rsp			 ==> Copy stack pointer to base pointer
push rbx			 ==> Push rbx value on to stack
sub rsp, 0x38			 ==> Take 56 bytes from the stack pointer
mov rax, qword fs:[0x28]	 ==> Stack guard init/canary stuff
mov qword [canary], rax 	 ==> copy rax to canary qword val
xor eax, eax			 ==> zero out eax register
lea rax, [var_40h]		 ==> load effective address of variable int o rax
mov rdi, rax			 ==> copy rax to rdi (for string operations)
call std::__cxx11::basic_string  ==> call to basic string function 
lea rsi, str.What_is_your_input  ==> load effective address of string 
lea rdi, std::cout	 	 ==> call cout function to print string
call std::basic_ostream 	 ==> call to basic outputstream function
mov rdx, rax 			 ==> copy rax value to rdx
mov rax, qword [std::endl_chars] ==> call to std endl function
mov rsi, rax			 ==> copy rax to rsi
mov rdi, rdx			 ==> copy rdx to rsi
call std::ostream		 ==> call to std outputstream function
lea rax, [var_40h]		 ==> load effective address of var to rax register
mov rsi, rax			 ==> copy rax to rsi
lea rdi, std::cin 		 ==> call to cin function
call std::basic_istream 	 ==> call to std input stream fucntion
lea rax, [var_40h]		 ==> load address of var to rax
lea rsi, str.testing 		 ==> copy "testing" to rsi string
mov rdi, rax			 ==> copy rax value to rdi
call bool std::operator==	 ==> call to "==" bool operator
test al, al			 ==> set ZF if values equal
je 0x55910265f30d 		 ==> if ZF is 0 jump to address
lea rsi, str.Test_Success	 ==> load "Test success" string to rsi
lea rdi, std::cout 		 ==> load std::cout to rdi 
call std::basic_ostream	 	 ==> call std output stream function for printing
mov rdx, rax			 ==> copy rax to rdx 
mov rax, qword [method.std::basic_ostream] ==> call std::ostream function
mov rsi, rax 			 ==> copy rax to rsi
mov rdi, rdx 			 ==> copy rdx to rdi
call std::ostream::operator      ==> call to output stream function
jmp 0x55910265f335 		 ==> jump here, will be hit if not success (else)
lea rsi, str.Test_Fail 		 ==> load "test fail" string to rsi
lea rdi, std::cout 		 ==> load address of cout for printing
call std::basic_ostream 	 ==> call to standard output function
mov rdx, rax			 ==> copy rax to rdx
mov rax, qword [method.std::edl] ==> endline
mov rsi, rax			 ==> copy rax to rsi
mov rdi, rdx			 ==> copy rdx to rdi
call std::ostream::operator 	 ==> call to output stream
mov ebx, 0			 ==> copy 0 to ebx
lea rax, [var_40h]		 ==> load address of var to rax
mov rdi, rax 			 ==> copy rax to rdi
call std::__cxx11::basic_string  ==> call to string func
mov eax, ebx 			 ==> copy ebx to eax
mov rcx, qword [canary] 	 ==> copy stack canary to rcx
xor rcx, qword fs:[0x28] 	 ==> stack canary init/check
je 0x55910265f37c 		 ==> if canary is okay jump here
jmp 0x55910265f377 		 ==> if canary is not okay jump here
endbr64				 ==> terminate / NOP
mov rbx, rax			 ==> copy rax to rbx
lea rax, [rbp - 0x40] 		 ==> load address of base pointer - 64 bytes
mov rdi, rax 			 ==> copy rax to rdi
call std::__cxx11::basic_string  ==> call to basic string function
mov rax, rbx 			 ==> copy rbx to rax
mov rdi, rax 			 ==> copy rax to rdi
call _Unwind_Resume 		 ==> call destructors etc
add rsp, 0x38 			 ==> add 56 to stack pointer
pop rbx	 			 ==> pop rbx from stack
pop rbp 			 ==> pop rbp from stack
ret				 ==> return/clear everything

